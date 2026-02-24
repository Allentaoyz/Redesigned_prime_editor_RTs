#!/bin/bash

source activate mlfold


output_dir="file_path" #change to your chosen name of the output directory 
mkdir $output_dir
input_dir="file_path" #change to the name of your target structure folder

path_for_parsed_chains=$output_dir"/file.jsonl" #change to your chosen name for parsed chain output

#parses the pdb file w multiple chains
python /file_path/parse_multiple_chains.py --input_path $input_dir \
    --output_path=$path_for_parsed_chains

path_for_chosen_chain=$output_dir"/file.jsonl" #change to your chosen name for chosen chain output

#assigns the chain to design
python /file_path/assign_fixed_chains.py --input_path $path_for_parsed_chains \
        --output_path $path_for_chosen_chain --chain_list "A" #change if designing a different chain

path_for_res=$output_dir"/file.jsonl" #change to chosen name of fixed positions output

#Prevent the chosen positions from being redesigned (specify fixed). All residues above conservation threshold, binding pocket.
#change the --position_list string to the "MPNN fix string" from your _constraints.csv file from the previous part
python /file_path/ProteinMPNN-main/helper_scripts/make_fixed_positions_dict.py  \
        --position_list "copy position numbers from previous outputs" --chain_list "A" \
        --input_path $path_for_parsed_chains --output_path $path_for_res

#change out_folder flag to your chosen output folder name. Change num_seq_per_target to desired value. 
python /file_path/ProteinMPNN-main/protein_mpnn_run.py --jsonl_path $path_for_parsed_chains \
        --omit_AAs "C" \
        --chain_id_jsonl $path_for_chosen_chain --fixed_positions_jsonl $path_for_res \
        --out_folder /file_path --num_seq_per_target 8 --sampling_temp "0.1 0.3" \
        --seed 0 --batch_size 1  --save_score 1  --save_probs 1
# change the name of output 
# change the number of sequences per target
# sampling temp keeps the same 
# leave all for the last row the same
