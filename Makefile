
overall_experiments: result_folder
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/DataSet/sygus_LIA_train/  --test-set ./Data/DataSet/sygus_LIA_test/ --num-parallel 20 --timeout 100 --seed 6 --RL-its 20 --result-file results/overall_exp_result_seed_2.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/DataSet/sygus_LIA_train/  --test-set ./Data/DataSet/sygus_LIA_test/ --num-parallel 20 --timeout 100 --seed 6 --RL-its 20 --result-file results/overall_exp_result_seed_3.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/DataSet/sygus_LIA_train/  --test-set ./Data/DataSet/sygus_LIA_test/ --num-parallel 20 --timeout 100 --seed 6 --RL-its 20 --result-file results/overall_exp_result_seed_4.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/DataSet/sygus_LIA_train/  --test-set ./Data/DataSet/sygus_LIA_test/ --num-parallel 20 --timeout 100 --seed 6 --RL-its 20 --result-file results/overall_exp_result_seed_5.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/DataSet/sygus_LIA_train/  --test-set ./Data/DataSet/sygus_LIA_test/ --num-parallel 20 --timeout 100 --seed 6 --RL-its 20 --result-file results/overall_exp_result_seed_6.json


train_new_test_old: result_folder
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/NewDataSet/new_compl_set  --test-set ./Data/OldDataSet/old_compl_set --num-parallel 20 --timeout 100 --seed 6 --RL-its 20 --result-file results/train_new_test_old_1.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/NewDataSet/new_compl_set  --test-set ./Data/OldDataSet/old_compl_set --num-parallel 20 --timeout 100 --seed 7 --RL-its 20 --result-file results/train_new_test_old_2.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/NewDataSet/new_compl_set  --test-set ./Data/OldDataSet/old_compl_set --num-parallel 20 --timeout 100 --seed 8 --RL-its 20 --result-file results/train_new_test_old_3.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/NewDataSet/new_compl_set  --test-set ./Data/OldDataSet/old_compl_set --num-parallel 20 --timeout 100 --seed 9 --RL-its 20 --result-file results/train_new_test_old_4.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/NewDataSet/new_compl_set  --test-set ./Data/OldDataSet/old_compl_set --num-parallel 20 --timeout 100 --seed 10 --RL-its 20 --result-file results/train_new_test_old_5.json


train_old_test_old: result_folder
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/OldDataSet/old_train  --test-set ./Data/OldDataSet/old_test/ --num-parallel 20 --timeout 100 --seed 11 --RL-its 20 --result-file results/train_and_test_old_bm_set_1.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/OldDataSet/old_train  --test-set ./Data/OldDataSet/old_test/ --num-parallel 20 --timeout 100 --seed 12 --RL-its 20 --result-file results/train_and_test_old_bm_set_2.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/OldDataSet/old_train  --test-set ./Data/OldDataSet/old_test/ --num-parallel 20 --timeout 100 --seed 13 --RL-its 20 --result-file results/train_and_test_old_bm_set_3.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/OldDataSet/old_train  --test-set ./Data/OldDataSet/old_test/ --num-parallel 20 --timeout 100 --seed 14 --RL-its 20 --result-file results/train_and_test_old_bm_set_4.json
	./build/FastPhyser --strategy AlphaZero_Circular -I ./Data/OldDataSet/old_train  --test-set ./Data/OldDataSet/old_test/ --num-parallel 20 --timeout 100 --seed 15 --RL-its 20 --result-file results/train_and_test_old_bm_set_5.json


result_folder:
	mkdir -p results
	mkdir -p tools/plots



all: overall_experiments train_new_test_old train_old_test_old
