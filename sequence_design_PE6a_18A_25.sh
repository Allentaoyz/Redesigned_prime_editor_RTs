#!/bin/bash

source activate mlfold


output_dir="/Users/taoallen/Desktop/ProteinMPNN_tutorial/PE_RT/Step_3_sequence_generation/Output/PE6a/18A_25_parsed_files" #change to your chosen name of the output directory 
mkdir $output_dir
input_dir="/Users/taoallen/Desktop/ProteinMPNN_tutorial/PE_RT/Step_3_sequence_generation/Target_Structure" #change to the name of your target structure folder

path_for_parsed_chains=$output_dir"/PE6a_AF3.jsonl" #change to your chosen name for parsed chain output

#parses the pdb file w multiple chains
python /Users/taoallen/Documents/ProteinMPNN-main/helper_scripts/parse_multiple_chains.py --input_path $input_dir \
    --output_path=$path_for_parsed_chains

path_for_chosen_chain=$output_dir"/PE6a_AF3_assigned.jsonl" #change to your chosen name for chosen chain output

#assigns the chain to design
python /Users/taoallen/Documents/ProteinMPNN-main/helper_scripts/assign_fixed_chains.py --input_path $path_for_parsed_chains \
        --output_path $path_for_chosen_chain --chain_list "A" #change if designing a different chain

path_for_res=$output_dir"/PE6a_AF3_fixed_pos.jsonl" #change to chosen name of fixed positions output

#Prevent the chosen positions from being redesigned (specify fixed). All residues above conservation threshold, binding pocket.
#change the --position_list string to the "MPNN fix string" from your _constraints.csv file from the previous part
python /Users/taoallen/Documents/ProteinMPNN-main/helper_scripts/make_fixed_positions_dict.py  \
        --position_list "1 2 3 4 5 6 7 8 10 11 12 14 19 21 22 26 27 30 31 33 35 36 37 38 39 40 43 44 46 47 48 50 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 132 133 134 135 136 137 138 139 140 141 142 143 144 145 147 149 152 153 162 167 168 170 171 172 173 174 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 196 200 202 205 206 207 208 210 211 212 213 214 215 216 217 218 219 220 221 222 224 225 226 227 228 229 235 238 239 244 245 246 247 248 249 250 251 252 253 254 257 258 259 260 261 262 263 264 265 266 267 268 269 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 293 294 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 359 360 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407" --chain_list "A" \
        --input_path $path_for_parsed_chains --output_path $path_for_res

#change out_folder flag to your chosen output folder name. Change num_seq_per_target to desired value. 
python /Users/taoallen/Documents/ProteinMPNN-main/protein_mpnn_run.py --jsonl_path $path_for_parsed_chains \
        --omit_AAs "C" \
        --chain_id_jsonl $path_for_chosen_chain --fixed_positions_jsonl $path_for_res \
        --out_folder /Users/taoallen/Desktop/ProteinMPNN_tutorial/PE_RT/Step_3_sequence_generation/Output/PE6a/PE6a_AF3_18A_25_designs --num_seq_per_target 8 --sampling_temp "0.1 0.3" \
        --seed 0 --batch_size 1  --save_score 1  --save_probs 1
# change the name of output 
# change the number of sequences per target
# sampling temp keeps the same 
# leave all for the last row the same
