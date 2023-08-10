import json
import matplotlib.pyplot as plt
import statistics
import pandas as pd
import os


def partition(p, l):
    a, b = [], []
    for n in l:
        if p(n):
            a.append(n)
        else:
            b.append(n)
    return a, b


def percentage(part, whole):
  return 100 * float(part)/float(whole)


def get_all_files_in_dir(dir, suffix):
    res = []
    for dirpath, dirnames, filenames in os.walk(dir):
        for filename in [f for f in filenames if f.endswith(suffix)]:
            if os.path.isfile(os.path.join(dirpath, filename)):
                res.append(os.path.join(dirpath, filename))
    return res


def all_files_in_dirs(dirs, suffix):
    res = []
    for dir in dirs:
        res = res + get_all_files_in_dir(dir, suffix)
    return res


generated_problem_set = list(map(lambda x: os.path.basename(x), all_files_in_dirs(["../Data/NewDataSet/new_compl_set/"], ".sl")))
old_problem_set = list(map(lambda x: os.path.basename(x), all_files_in_dirs(["../Data/OldDataSet/old_compl_set/"], ".sl")))


def accum_left(lst):
    res = [lst[0]]
    for idx, e in enumerate(lst[1:]):
        res.append(res[idx]+e)
    return res


def plot_solved_over_time(file):
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


def plot_solved_over_iterations(file):
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


def print_stats(file, flag=True):
    data = None
    with open(file) as f:
        data = json.load(f)
    iterations = data["iterations"]
    all_training = len(data["all_problems"])
    all_testing = len(data["testing_set_problems"])
    all_old_training, _ = partition(lambda x: os.path.basename(x) in old_problem_set, data["all_problems"])
    all_old_testing,_ = partition(lambda x: os.path.basename(x) in old_problem_set, data["testing_set_problems"])

    succ_train = []
    succ_test = []
    for idx, it in enumerate(iterations):
        succ_train.append(len(it["successful"]))
        succ_test.append(len(it["successful_test"]))
    print()

    print("Solved Training:")
    df = pd.DataFrame()
    df[0] = succ_train
    min = int(df.min().iloc[0])
    max = int(df.max().iloc[0])
    print("min {}\t max {}\t total {}".format(min, max, all_training))
    print("Increase by {:5.2f}%".format((float(max) - float(min))*100/min))
    print("Solved as % of all min: {:5.2f}% and max: {:5.2f}% with diff {:5.2f}%"
          .format(min*100/all_training, max*100/all_training, (max*100/all_training) - (min*100/all_training) ))
    print()

    print("Solved Testing:")
    df = pd.DataFrame()
    df[0] = succ_test
    min = int(df.min().iloc[0])
    max = int(df.max().iloc[0])
    print("min {}\t max {}\t total {}".format(min, max, all_testing))
    print("Increase by {:5.2f}%".format((float(max) - float(min))*100/min))
    print("Solved as % of all min: {:5.2f}% and max: {:5.2f}% with diff {:5.2f}%"
          .format(min*100/all_testing, max*100/all_testing, (max*100/all_testing) - (min*100/all_testing) ))
    print()
    print("{:6}".format("Iter"), end="")
    for idx, train in enumerate(succ_train):
        print("{:15}".format(idx+1), end="")
    print()
    print("{:6}".format("Train"), end="")
    for train in succ_train:
        print("{:15}".format(train), end="")
    print()
    if flag:
        print("{:6}".format("TR Old"), end="")
        for idx, it in enumerate(iterations):
            succ_train.append(len(it["successful"]))
            old, _ = partition(lambda x: os.path.basename(x["problem"]) in old_problem_set, it["successful"])
            print("{:>15}".format(str(len(old)) + "/" + str(len(all_old_training))), end="")
        print()
        print("{:6}".format("TR New"), end="")
        for idx, it in enumerate(iterations):
            succ_train.append(len(it["successful"]))
            gen, _ = partition(lambda x: os.path.basename(x["problem"]) in generated_problem_set, it["successful"])
            print("{:8} {:3.2f}%".format(len(gen), percentage(len(gen), len(it["successful"]))), end="")
        print()
    print("{:6}".format("Test"), end="")
    for test in succ_test:
        print("{:15}".format(test), end="")
    print()
    if flag:
        print("{:6}".format("Te Old"), end="")
        for idx, it in enumerate(iterations):
            succ_train.append(len(it["successful"]))
            old, _ = partition(lambda x: os.path.basename(x["problem"]) in old_problem_set, it["successful_test"])
            print("{:>15}".format(str(len(old)) + "/" + str(len(all_old_testing))), end="")

        print()
        print("{:6}".format("Te New"), end="")
        for idx, it in enumerate(iterations):
            succ_train.append(len(it["successful"]))
            gen, _ = partition(lambda x: os.path.basename(x["problem"]) in generated_problem_set, it["successful_test"])
            print("{:8} {:3.2f}%".format(len(gen), percentage(len(gen), len(it["successful_test"]))), end="")
        print()

        print("TR Old/Gen means number of old benchmark and generated benchmark problems solved in training.")
        print("TE Old/Gen means number of old benchmark and generated benchmark problems solved in testing.")

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
    plt.clf()
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


def calc_stats_for_mult_exp_files(files):
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
    print("Best {}\t Worst {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df.max().max(), df.max().min(), df.max().mean(), df.max().std() ))

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
    print("Best {}\t Worst {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df.max().max(), df.max().min(), df.max().mean(), df.max().std() ))


def main():
    overall_files = [
             "../results/overall_exp_result_seed_2.json",
             "../results/overall_exp_result_seed_3.json",
             "../results/overall_exp_result_seed_4.json",
             "../results/overall_exp_result_seed_5.json",
             "../results/overall_exp_result_seed_6.json",
             ]

    tain_old_test_old = [
            "../results/train_and_test_old_bm_set_1.json",
            "../results/train_and_test_old_bm_set_2.json",
            #"../results/train_and_test_old_bm_set_3.json",
            #"../results/train_and_test_old_bm_set_4.json",
            #"../results/train_and_test_old_bm_set_5.json",
    ]

    train_new_test_old = [
            "../results/train_new_test_old_1.json",
            "../results/train_new_test_old_2.json",
            #"../results/train_new_test_old_3.json",
            #"../results/train_new_test_old_4.json",
            #"../results/train_new_test_old_5.json",
    ]

    print("############################################")
    print("########## OVERALL EXPERIMENTS #############")
    print("############################################")
    print()
    plot_iterations_in_experiements(overall_files)
    calc_stats_for_mult_exp_files(overall_files)
    print()
    print()
    print("############################################")
    print("## Stats of Single OVERALL Experiment RUN ##")
    print("############################################")
    one_experiment = overall_files[4]
    print_stats(one_experiment, True)
    plot_solved_over_time(one_experiment)
    plot_solved_over_iterations(one_experiment)
    print()
    print()
    print("############################################")
    print("###### TRAIN ON GENERATED/TEST on BM #######")
    print("############################################")
    print()
    calc_stats_for_mult_exp_files(train_new_test_old)
    print_stats(train_new_test_old[0], False)
    print()
    print()
    print("############################################")
    print("######### TRAIN ON BM/TEST on BM ###########")
    print("############################################")
    calc_stats_for_mult_exp_files(tain_old_test_old)
    print_stats(tain_old_test_old[0], False)


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    main()