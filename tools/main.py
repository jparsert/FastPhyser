import json
import matplotlib.pyplot as plt
import statistics
import pandas as pd


files = [   "../results/experiment_result_d8872f8_seed_2.json",
            "../results/experiment_result_d8872f8_seed_3.json",
            "../results/experiment_result_d8872f8_seed_4.json",
            "../results/experiment_result_d8872f8_seed_5.json",
            "../results/experiment_result_d8872f8_seed_6.json",
         ]

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

    for idx, it in enumerate(iterations):
        y = [0] * (max_time + 1)
        successful = it["successful"]
        for e in successful:
            y[min(e["search_time_seconds"], max_time )] += 1
        y = accum_left(y)
        if idx > 0:
            plt.plot(x, y)
        else:
            plt.plot(x,y, linestyle="dashed")
    plt.xlabel('time (s)')
    plt.ylabel('solved problems')
    plt.savefig('plots/training_solved_over_time.eps', format='eps')
    plt.show()

    plt.clf()

    for idx, it in enumerate(iterations):
        y = [0] * (max_time + 1)
        successful = it["successful_test"]
        for e in successful:
            y[e["search_time_seconds"]] += 1
        y = accum_left(y)
        if idx > 0:
            plt.plot(x, y)
        else:
            plt.plot(x, y, linestyle="dashed")
    plt.xlabel('time (s)')
    plt.ylabel('solved problems')
    plt.savefig('plots/testing_solved_over_time.eps', format='eps')
    plt.show()


def solved_over_iterations(file):
    data = None
    with open(file) as f:
        data = json.load(f)
    iterations = data["iterations"]
    x = range(1, len(iterations) + 1)
    y = []
    for it in iterations:
        y.append(len(it["successful"]))

    fig, ax = plt.subplots()
    ax.bar(x, y)
    plt.xticks(range(1,len(iterations,) + 1, 2))
    plt.xlabel("Solved Problems on Training Set")
    plt.ylim(0, len(data["all_problems"]) )
    plt.xlabel('iteration')
    plt.ylabel('solved problems')
    plt.savefig('plots/training_solved_over_iterations.eps', format='eps')
    plt.show()

    plt.clf()

    fig, ax = plt.subplots()
    y = []
    for it in iterations:
        y.append(len(it["successful_test"]))
    ax.bar(x, y)
    plt.xticks(range(1,len(iterations,) + 1, 2))
    plt.xlabel('iteration')
    plt.ylabel('solved problems')

    plt.ylim(0, len(data["testing_set_problems"]) )
    #ax.xlabel('iteration')
    #ax.ylabel('solved problems')
    plt.savefig('plots/test_solved_over_iterations.eps', format='eps')
    plt.show()


def print_stats(file):
    data = None
    with open(file) as f:
        data = json.load(f)
    iterations = data["iterations"]
    succ_train = []
    succ_test = []
    for idx, it in enumerate(iterations):
        print("{:10}".format(idx+1), end="")
        succ_train.append(len(it["successful"]))
        succ_test.append(len(it["successful_test"]))
    print()
    print("Solved Training:")
    for train in succ_train:
        print("{:10}".format(train), end="")
    print()
    print("Solved Testing:")
    for test in succ_test:
        print("{:10}".format(test), end="")
    print()
    print("Average Time For Solved problem in Training")
    for it in iterations:
        times = []
        for solved in it["successful"]:
            times.append(solved["search_time_seconds"])
        print("{:10.2f}".format(statistics.mean(times)), end="")
    print()
    print("Average Time For Solved problem in Test")
    for it in iterations:
        times = []
        for solved in it["successful_test"]:
            times.append(solved["search_time_seconds"])
        print("{:10.2f}".format(statistics.mean(times)), end="")
    print()
    print("Time for whole training iteration as ratio to first iteration:")
    for it in iterations:
        print("{:10.2f}".format(it["iteration_time_training"]/iterations[0]["iteration_time_training"]), end="")
    print()


def plot_iterations_in_experiements(files):
    iterations = 0
    for file in files:
        data = None
        with open(file) as f:
            data = json.load(f)
        iterations = data["iterations"]
        x = range(1, len(iterations) + 1)
        y = []
        for it in iterations:
            y.append(len(it["successful"]))

        plt.plot(x, y)
    plt.xticks(range(1, len(iterations, ) + 1, 2))
    plt.xlabel("Solved Problems on Training Set")
    plt.ylim(0, len(data["all_problems"]))
    plt.xlabel('iteration')
    plt.ylabel('solved problems')
    plt.savefig('plots/training_solved_over_iterations.eps', format='eps')
    plt.show()


def calc_stats_for_experiemnts(files):
    df = pd.DataFrame()
    for idx, file in enumerate(files):
        data = None
        with open(file) as f:
            data = json.load(f)
        iterations = data["iterations"]
        solved = []
        for it in iterations:
            solved.append(len(it["successful"]))
        df[idx] = solved
    print("The best (most solved on training set) iterations in each experiment differ from each other as follows:")
    print("Best {}\t Worst {}\t STDEV {:5.2f}".format(df.max().max(), df.max().min(), df.max().std() ))

    df = pd.DataFrame()
    for idx, file in enumerate(files):
        data = None
        with open(file) as f:
            data = json.load(f)
        iterations = data["iterations"]
        solved = []
        for it in iterations:
            solved.append(len(it["successful_test"]))
        df[idx] = solved
    print("The best (most solved on testing set) iterations in each experiment differ from each other as follows:")
    print("Best {}\t Worst {}\t STDEV {:5.2f}".format(df.max().max(), df.max().min(), df.max().std() ))



# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    plot_iterations_in_experiements(files)
    calc_stats_for_experiemnts(files)
    f = files[2]
    print_stats(f)
    calc_solves_over_time(f)
    solved_over_iterations(f)
# See PyCharm help at https://www.jetbrains.com/help/pycharm/
