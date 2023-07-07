import json
import matplotlib.pyplot as plt


FILE = "/home/julian/coding/FastPhyser/results/experiment_results07-07-2023||09-31-46.json"


def accum_left(lst):
    res = [lst[0]]
    for idx, e in enumerate(lst[1:]):
        res.append(res[idx]+e)
    return res


def calc_solves_over_time(file):
    data = None
    with open(file) as f:
        data = json.load(f)
    iterations = data["iterations"]
    max_time = data["timeout"] + 5
    x = list(range(0, max_time+1))

    for it in iterations:
        y = [0] * (max_time + 1)
        successful = it["successful"]
        for e in successful:
            y[e["search_time_seconds"]] += 1
        y = accum_left(y)
        plt.plot(x, y)
    plt.xlabel('time (s)')
    plt.ylabel('solved problems')
    plt.show()

    plt.clf()
    for it in iterations:
        y = [0] * (max_time + 1)
        successful = it["successful_test"]
        for e in successful:
            y[e["search_time_seconds"]] += 1
        y = accum_left(y)
        plt.plot(x, y)

    plt.xlabel('time (s)')
    plt.ylabel('solved problems')

    plt.show()

    plt.clf()

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    calc_solves_over_time(FILE)

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
