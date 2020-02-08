from math import radians, cos, sin, asin, sqrt, atan2, degrees


def haversine(pointA, pointB):
    if (type(pointA) != tuple) or (type(pointB) != tuple):
        raise TypeError("Only tuples are supported as arguments")
    lat1 = pointA[0]
    lon1 = pointA[1]
    lat2 = pointB[0]
    lon2 = pointB[1]
    lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
    c = 2 * asin(sqrt(a))
    r = 6371
    return c * r


def initial_bearing(pointA, pointB):
    if (type(pointA) != tuple) or (type(pointB) != tuple):
        raise TypeError("Only tuples are supported as arguments")
    lat1 = radians(pointA[0])
    lat2 = radians(pointB[0])
    diffLong = radians(pointB[1] - pointA[1])
    x = sin(diffLong) * cos(lat2)
    y = cos(lat1) * sin(lat2) - (sin(lat1) * cos(lat2) * cos(diffLong))
    initial_bearing = atan2(x, y)
    initial_bearing = degrees(initial_bearing)
    compass_bearing = (initial_bearing + 360) % 360
    return compass_bearing


pA = (43.314167, -0.363889)
pB = (43.31400, -0.36362)
print haversine(pA, pB)
print initial_bearing(pA, pB)
