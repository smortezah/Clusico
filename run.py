import os
import shutil
import matplotlib.pyplot as plt
import numpy as np

find_simil_seqs = True

if os.name == 'posix':
    sep = '/'
elif os.name == 'nt':
    sep = '\\'
dataset_path = 'dataset' + sep
geco = 'bin/GeCo '

# prepare_data = False
# numerate_dataset = False
# denumerate_dataset = False
# find_simil_regions = False
# plot_rearrange_count = False
# make_rearrange_mat_symmetric = False
# plot_simil = False

# main_file = 'mtDNA_Chordata_3327_22-03-2019.fasta'
# data_in_path = 'Taxonomy_Chordata_NCBI_Diogo_06-05-2019'
# # num_files = 3327
# ave_ent_file = 'ent'
# threshold = 0.2  # in (0, 1]
# ent_threshold = 8 * threshold
# group_list = ['Mammalia', 'Agnatha', 'Placodermes', 'Chondrichthyes',
#               'Actinopterygii', 'Sarcopterygii']
# result_path = 'result'


def execute(cmd):
    os.popen(cmd).read()


if find_simil_seqs:
    in_file_path = dataset_path
    in_file_list = os.listdir(in_file_path)
    print(in_file_list)
    # out_file_name = ave_ent_file + '_Chondrichthyes.tsv'
    # if os.path.exists(out_file_name):
    #     os.remove(out_file_name)
    # out_file = open(out_file_name, "w")
    # for file in in_file_list:
    #     out_file.write('\t' + file[:-4])
    # out_file.write('\n')

    # first = 0
    # for i in range(first, len(in_file_list)):
    #     out_file.write(in_file_list[i][:-4])
    #     for j in range(first, len(in_file_list)):
    #         ref = in_file_path + sep + in_file_list[i]
    #         tar = in_file_path + sep + in_file_list[j]
    #         execute(geco + '-rm 6:1:0:0/0 -rm 10:10:1:0/0 -rm 14:50:1:3/10 ' +
    #                 '-c 30 -g 0.95 -r ' + ref + ' ' + tar + ' > log')

    #         with open('log', 'r') as log_file:
    #             for line in log_file:
    #                 line_list = line.split()
    #                 if len(line_list) > 5:
    #                     out_file.write('\t' + str(line_list[5]))
    #     out_file.write('\n')

    # for file in ["log", "*.co"]:
    #     if os.path.exists(file):
    #         os.remove(file)