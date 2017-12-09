def jobOffers(scores, lowerLimits, upperLimits):
    return [len([x for x in scores if x >= limit[0] and x <= limit[1]]) for limit in zip(lowerLimits, upperLimits)]


from urllib import request
import json


def getMovieTitles(substr):
    url = 'https://jsonmock.hackerrank.com/api/movies/search/?Title=%s&page=&s'
    page = 1
    response = request.urlopen(url % (substr, page))
    result = json.loads(response.read().decode('utf-8'))
    pages = result['total_pages']
    titles = [t['Title'] for t in result['data']]

    if pages > 1:
        for page in range(2, pages + 1):
            response = request.urlopen(url % (substr, page))
            result = json.loads(response.read().decode('utf-8'))
            titles.extend([t['Title'] for t in result['data']])
    return list(sorted(titles))


def budgetShopping(n, bundleQuantities, bundleCosts):
    total = 0
    all_ = sorted(zip(bundleQuantities, bundleCosts), reverse=True)
    qty, cost = all_[0]
    len_all = len(all_) - 1
    index = 0
    while index <= len_all:
        max_qty = n % cost
        if max_qty:
            total += (max_qty * qty)
            rest = n - max_qty * cost

            if index < len_all:
                possible = [x for x in all_[index + 1:] if x[1] <= rest]
                if not possible:
                    break
            n = rest
            index += 1
            qty, cost = possible[0]
        else:
            break
    return total


from PyPDF2 import PdfFileReader, PdfFileWriter

fin = open('./python/Undergradute-transcripts-and-others.pdf', 'rb')
pdf_in = PdfFileReader(fin)

pdf_out = PdfFileWriter()
# x = [pdf_out.addPage(pdf_in.getPage(x)) for x in range(4)]
pdf_out.addPage(pdf_in.getPage(4))
pdf_out.write(open('./python/Undergradute-certificate.pdf', 'wb'))
