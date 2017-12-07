def slices0(series, length):
    len_series = len(series)
    if not length or len_series < length:
        raise ValueError()
    result = []
    for index, slice_begin in enumerate(range(len_series - length + 1)):
        result.append([int(x) for x in series[slice_begin:length + index]])
    return result


def slices(series, length):
    len_series = len(series)
    if not length or len_series < length:
        raise ValueError()
    return [
        [int(x) for x in series[slice_index:length + slice_index]]
        for slice_index in range(len_series - length + 1)
    ]
