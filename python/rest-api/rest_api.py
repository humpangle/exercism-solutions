import json


class RestAPI(object):
    OWED_BY_KEY = 'owed_by'
    BALANCE = 'balance'
    OWES_KEY = 'owes'

    """We always receive the initial data as {'users': [list of users]}
    but we convert it internally to {'users': {key_name_of_user: data}} for
    O(1) lookup
    """

    def __init__(self, database=None):
        self.database = {'users': {}}
        if database:
            self.database = {
                'users': self.db_users_from_list(database['users'])}

        self.posts = {
            '/add': self.post_add_user,
            '/iou': self.post_iou
        }

    def post_add_user(self, payload):
        payload = json.loads(payload)
        name = payload['user']
        new_user = self.new_user(name)
        self.database["users"][name] = new_user
        return json.dumps(new_user)

    def post_iou(self, payload):
        payload = json.loads(payload)
        lender, borrower, amount = payload['lender'], payload['borrower'], payload['amount']

        lender_data = self.database['users'].get(lender, self.new_user(lender))
        borrower_data = self.database['users'].get(
            borrower, self.new_user(borrower))

        lender_owes = lender_data[self.OWES_KEY]
        lender_owed_by = lender_data[self.OWED_BY_KEY]
        borrower_owes = borrower_data[self.OWES_KEY]
        borrower_owed_by = borrower_data[self.OWED_BY_KEY]

        lender_owes_borrower = lender_owes.get(borrower, 0) - amount
        net_owing = abs(lender_owes_borrower)

        if lender_owes_borrower < 0:
            lender_owes.pop(borrower, None)
            lender_owed_by[borrower] = net_owing

            borrower_owes[lender] = net_owing
            borrower_owed_by.pop(lender, None)
        elif lender_owes_borrower > 0:
            lender_owed_by.pop(borrower, None)
            lender_owes[borrower] = net_owing

            borrower_owes.pop(lender, None)
            borrower_owed_by[lender] = net_owing
        else:
            lender_owes.pop(borrower, None)
            lender_owed_by.pop(borrower, None)

            borrower_owes.pop(lender, None)
            borrower_owed_by.pop(lender, None)

        lender_data[self.BALANCE] = lender_data[self.BALANCE] + amount
        borrower_data[self.BALANCE] = borrower_data[self.BALANCE] - amount

        return json.dumps({'users': sorted([lender_data, borrower_data], key=lambda x: x['name'])})

    def get(self, url, payload=None):
        if payload is None:
            return json.dumps({'users': self.db_users_to_list()})

        payload = json.loads(payload)
        users_to_get = payload["users"]
        db_users = self.database['users']
        return json.dumps({
            'users': [db_users[x] for x in users_to_get]
        })

    def post(self, url, payload=None):
        return self.posts[url](payload)

    def get_user_by_name(self, name):
        return next([x for x in self.database['users'] if x == name], None)

    def db_users_from_list(self, users):
        return {data['name']: data for data in users}

    def db_users_to_list(self):
        return list(dict.values(self.database['users']))

    def new_user(self, name):
        return {
            'name': name,
            'owes': {},
            self.OWED_BY_KEY: {},
            self.BALANCE: 0
        }


from functools import wraps
import json


def json_io(func):
    @wraps(func)
    def dec(self, url, payload=None):
        if payload is not None and isinstance(payload, str):
            payload = json.loads(payload)
        return json.dumps(func(self, url, payload), indent=2)
    return dec


class User(object):
    def __init__(self, name, owed_by=None, owes=None, **kwargs):
        self.name = name
        self.records = {}
        for borrower, amount in (owed_by or {}).items():
            self.loan(borrower, amount)
        for lender, amount in (owes or {}).items():
            self.borrow(lender, amount)

    def borrow(self, borrower, amount):
        self.records[borrower] = self.records.get(borrower, 0) - amount

    def loan(self, lender, amount):
        self.records[lender] = self.records.get(lender, 0) + amount

    @property
    def owes(self):
        return {k: -v for k, v in self.records.items() if v < 0}

    @property
    def owed_by(self):
        return {k: v for k, v in self.records.items() if v > 0}

    @property
    def balance(self):
        return sum(self.records.values())

    @property
    def __dict__(self):
        return {
            'name': self.name,
            'owes': self.owes,
            'owed_by': self.owed_by,
            'balance': self.balance
        }


class RestAPI1(object):
    def __init__(self, database=None):
        self.users = {
            user['name']: User(**user)
            for user in (database or {}).get('users', [])
        }

    @json_io
    def get(self, url, payload=None):
        if url == '/users':
            return {'users': [
                user.__dict__
                for name, user in sorted(self.users.items())
                if payload is None or name in payload['users']
            ]}

    @json_io
    def post(self, url, payload):
        if url == '/add':
            user = User(payload['user'])
            self.users[user.name] = user
            return user.__dict__
        elif url == '/iou':
            lender = self.users[payload['lender']]
            borrower = self.users[payload['borrower']]
            amount = payload['amount']
            lender.loan(borrower.name, amount)
            borrower.borrow(lender.name, amount)
            return {'users': sorted(
                [lender.__dict__, borrower.__dict__],
                key=lambda u: u['name']
            )}
