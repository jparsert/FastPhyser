import json
import matplotlib.pyplot as plt
import statistics

import numpy
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

# f needs to be a path (I think) otherwise the call to os.path.basename fails. (change accordingly)
def in_old(f):
    return os.path.basename(f) in old_problem_set

def in_new(f):
    return os.path.basename(f) in generated_problem_set


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


def a_entries_not_in_b(a, b):
    res = []
    for e in a:
        if e not in b:
            res.append(e)
    return res


def unique_problems(files):
    test_files_solved_cvc5 = []
    with open("solved_test_cvc5.txt") as f:
        test_files_solved_cvc5 = f.readlines()

    train_files_solved_cvc5 = []
    with open("solved_train_cvc5.txt") as f:
        train_files_solved_cvc5 = f.readlines()

    train_files_solved_cvc5 = list(map(lambda x: x.strip()[:-9], train_files_solved_cvc5))
    test_files_solved_cvc5 = list(map(lambda x: x.strip()[:-9], test_files_solved_cvc5))


    train_files_solved = []
    test_files_solved = []

    best_train_iterations = []
    best_test_iterations = []

    for file in files:
        data = None
        with open(file) as f:
            data = json.load(f)
        iterations = data["iterations"]
        best_train_it_idx = numpy.argmax(list(map(lambda it: len(it["successful"]), iterations)))
        best_train_iterations.append(list(map(lambda x: os.path.basename(x["problem"]), iterations[best_train_it_idx]["successful"])))

        best_test_it_idx = numpy.argmax(list(map(lambda it: len(it["successful_test"]), iterations)))
        best_test_iterations.append(list(map(lambda x: os.path.basename(x["problem"]), iterations[best_test_it_idx]["successful_test"])))

    unique_files_in_best_train_it = list(map(lambda x: len(a_entries_not_in_b(x, train_files_solved_cvc5)), best_train_iterations))
    unique_files_in_best_test_it = list(map(lambda x: len(a_entries_not_in_b(x, test_files_solved_cvc5)), best_test_iterations))
    print("Unique Training problems in best iterations:")
    print(unique_files_in_best_train_it)
    print("Unique Testing problems in best iterations:")
    print(unique_files_in_best_test_it)


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
    plt.savefig('plots/training_solved_over_iterations_in_exp.eps', format='eps')

    plt.clf()
    for file in files:
        data = None
        with open(file) as f:
            data = json.load(f)
        iterations = data["iterations"]
        x = range(1, len(iterations) + 1)
        y = []
        for it in iterations:
            y.append(len(it["successful_test"]))

        plt.plot(x, y)
    plt.xticks(range(1, len(iterations, ) + 1, 2))
    plt.xlabel("Solved Problems on Testing Set")
    plt.ylim(0, len(data["testing_set_problems"]))
    plt.xlabel('iteration')
    plt.ylabel('solved problems')
    plt.savefig('plots/testing_solved_over_iterations_in_exp.eps', format='eps')


def calc_stats_for_mult_exp_files(files):
    df = pd.DataFrame()
    df_in_old = pd.DataFrame()
    for idx, file in enumerate(files):
        data = None
        with open(file) as f:
            data = json.load(f)
        iterations = data["iterations"]
        solved = []
        solved_old = []
        for it in iterations:
            solved.append(len(it["successful"]))
            solved_old.append(len(partition(lambda x: os.path.basename(x["problem"]) in old_problem_set, it["successful"])[0]))
        df[idx] = solved
        df_in_old[idx] = solved_old
    print("The best (most solved on training set) iterations in each experiment differ from each other on TRAINING as follows:")
    print("Best {}\t Worst {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df.max().max(), df.max().min(), df.max().mean(), df.max().std() ))
    print("Parts of old data set (Total:{})".format(len(partition(lambda x: os.path.basename(x) in old_problem_set, data["all_problems"])[0])))
    print("Best {}\t Worst {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df_in_old.max().max(), df_in_old.max().min(), df_in_old.max().mean(), df_in_old.max().std() ))
    print()

    print("The Worst (least on training set) iterations in each experiment differ from each other on TRAINING as follows:")
    print("Worst {}\t Worst {}\t Mean of Worst {}\t STDEV of Worst {:5.2f}".format(df.min().max(), df.min().min(), df.min().mean(), df.min().std() ))
    print("Parts of old data set (Total:{})".format(len(partition(lambda x: os.path.basename(x) in old_problem_set, data["all_problems"])[0])))
    print("Worst {}\t Worst {}\t Mean of Worst {}\t STDEV of Worst {:5.2f}".format(df_in_old.min().max(), df_in_old.min().min(), df_in_old.min().mean(), df_in_old.min().std() ))
    print()
    df = pd.DataFrame()
    df_in_old = pd.DataFrame()
    for idx, file in enumerate(files):
        data = None
        with open(file) as f:
            data = json.load(f)
        iterations = data["iterations"]
        solved = []
        solved_old = []
        for it in iterations:
            solved.append(len(it["successful_test"]))
            solved_old.append(len(partition(lambda x: os.path.basename(x["problem"]) in old_problem_set, it["successful_test"])[0]))
        df[idx] = solved
        df_in_old[idx] = solved_old
    print("The best (most solved on testing set) iterations in each experiment differ from each other as follows:")
    print("max {}\t min {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df.max().max(), df.max().min(), df.max().mean(), df.max().std() ))
    print("Parts of old data set (Total:{})".format(len(partition(lambda x: os.path.basename(x) in old_problem_set, data["testing_set_problems"])[0])))
    print("max {}\t min {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df_in_old.max().max(), df_in_old.max().min(), df_in_old.max().mean(), df_in_old.max().std() ))
    print()
    print("The worst (least solved on testing set) iterations in each experiment differ from each other as follows:")
    print("max {}\t min {}\t Mean of worst {}\t STDEV of worst {:5.2f}".format(df.min().max(), df.min().min(), df.min().mean(), df.min().std() ))
    print("Parts of old data set (Total:{})".format(len(partition(lambda x: os.path.basename(x) in old_problem_set, data["testing_set_problems"])[0])))
    print("max {}\t min {}\t Mean of worst {}\t STDEV of worst {:5.2f}".format(df_in_old.min().max(), df_in_old.min().min(), df_in_old.min().mean(), df_in_old.min().std() ))




def calc_stats_subset_of(files, superset):

    print("############################################")
    print("##SUBSET STATS ##")
    print("############################################")

    the_subset = None
    with open(superset[0]) as f:
        data = json.load(f)
        the_subset = data["testing_set_problems"]

    print("Subset size: {}".format(len(the_subset)))

    the_subset = list(map(lambda x: os.path.basename(x), the_subset))

    df = pd.DataFrame()
    df_in_old = pd.DataFrame()
    for idx, file in enumerate(files):
        data = None
        with open(file) as f:
            data = json.load(f)
        iterations = data["iterations"]
        solved = []
        solved_old = []
        for it in iterations:
            solved.append(len([e for e in it["successful"] if e["problem"] in the_subset]))
            solved_old.append(len(partition(lambda x: os.path.basename(x["problem"]) in old_problem_set, it["successful"])[0]))
        df[idx] = solved
        df_in_old[idx] = solved_old
    print("The best (most solved on training set) iterations in each experiment differ from each other on TRAINING as follows:")
    print("Best {}\t Worst {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df.max().max(), df.max().min(), df.max().mean(), df.max().std() ))
    print("Parts of old data set (Total:{})".format(len(partition(lambda x: os.path.basename(x) in old_problem_set, data["all_problems"])[0])))
    print("Best {}\t Worst {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df_in_old.max().max(), df_in_old.max().min(), df_in_old.max().mean(), df_in_old.max().std() ))
    print()

    print("The Worst (least on training set) iterations in each experiment differ from each other on TRAINING as follows:")
    print("Worst {}\t Worst {}\t Mean of Worst {}\t STDEV of Worst {:5.2f}".format(df.min().max(), df.min().min(), df.min().mean(), df.min().std() ))
    print("Parts of old data set (Total:{})".format(len(partition(lambda x: os.path.basename(x) in old_problem_set, data["all_problems"])[0])))
    print("Worst {}\t Worst {}\t Mean of Worst {}\t STDEV of Worst {:5.2f}".format(df_in_old.min().max(), df_in_old.min().min(), df_in_old.min().mean(), df_in_old.min().std() ))
    print()
    df = pd.DataFrame()
    df_in_old = pd.DataFrame()
    for idx, file in enumerate(files):
        data = None
        with open(file) as f:
            data = json.load(f)
        iterations = data["iterations"]
        solved = []
        solved_old = []
        for it in iterations:
            solved.append(len([e for e in it["successful_test"] if os.path.basename(e["problem"]) in the_subset]))
            solved_old.append(len(partition(lambda x: os.path.basename(x["problem"]) in old_problem_set, it["successful_test"])[0]))
        df[idx] = solved
        df_in_old[idx] = solved_old
    print("The best (most solved on testing set) iterations in each experiment differ from each other as follows:")
    print("max {}\t min {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df.max().max(), df.max().min(), df.max().mean(), df.max().std() ))
    print("Parts of old data set (Total:{})".format(len(partition(lambda x: os.path.basename(x) in old_problem_set, data["testing_set_problems"])[0])))
    print("max {}\t min {}\t Mean of best {}\t STDEV of best {:5.2f}".format(df_in_old.max().max(), df_in_old.max().min(), df_in_old.max().mean(), df_in_old.max().std() ))
    print()
    print("The worst (least solved on testing set) iterations in each experiment differ from each other as follows:")
    print("max {}\t min {}\t Mean of worst {}\t STDEV of worst {:5.2f}".format(df.min().max(), df.min().min(), df.min().mean(), df.min().std() ))
    print("Parts of old data set (Total:{})".format(len(partition(lambda x: os.path.basename(x) in old_problem_set, data["testing_set_problems"])[0])))
    print("max {}\t min {}\t Mean of worst {}\t STDEV of worst {:5.2f}".format(df_in_old.min().max(), df_in_old.min().min(), df_in_old.min().mean(), df_in_old.min().std() ))

    print("############################################")
    print()
    print()



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
            "../results/train_and_test_old_bm_set_3.json",
            "../results/train_and_test_old_bm_set_4.json",
            "../results/train_and_test_old_bm_set_5.json",
    ]

    train_new_test_old = [
            "../results/train_new_test_old_1.json",
            "../results/train_new_test_old_2.json",
            "../results/train_new_test_old_3.json",
            "../results/train_new_test_old_4.json",
            "../results/train_new_test_old_5.json",
    ]
    const = 0

    print("############################################")
    print("########## OVERALL EXPERIMENTS #############")
    print("############################################")
    print()
    plot_iterations_in_experiements(overall_files)
    calc_stats_for_mult_exp_files(overall_files)
    print()
    unique_problems(overall_files)
    print()
    print("############################################")
    print("## Stats of Single OVERALL Experiment RUN ##")
    print("############################################")
    one_experiment = overall_files[const]
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
    calc_stats_subset_of(train_new_test_old, tain_old_test_old)
    print_stats(train_new_test_old[const], False)
    print()
    print()
    print("############################################")
    print("######### TRAIN ON BM/TEST on BM ###########")
    print("############################################")
    calc_stats_for_mult_exp_files(tain_old_test_old)
    print_stats(tain_old_test_old[const], False)



# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    main()
