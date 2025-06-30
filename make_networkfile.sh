#change to directory with MINI-EX output folder
cd /scratch/ctf277/guardGRN/Nguyen_et_al_2025

#!/bin/bash
#add ranked_regulons information to edge table to form network file
echo -e "TF\tTG\tcluster\tborda_rank\tborda_clusterRank\tweight\talias\thasTFrelevantGOterm\tGOterm\tGOdescription\ttf_cluster\tcelltype\tisTF_DE\ttotRegInCluster\t#TGs\tqval_cluster\tout-degree\tcloseness\tbetweenness\tmed_coexpr\tTF_qval\ttf_borda_rank\ttf_borda_clusterRank" > ATHA_NOMOTIF_OUTPUTS/regulons/ATHA_network.tsv

awk 'BEGIN{FS=OFS="\t"} 
NR==FNR && NR>1 {
    split($6, parts, "_")
    cluster_id = "Cluster_" parts[3]
    key = $1"_"cluster_id
    tf_info[key] = $2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12"\t"$13"\t"$14"\t"$15"\t"$16"\t"$17"\t"$18
    next
} 
NR>1 && FNR>1 {
    key = $1"_"$3
    if (key in tf_info) {
        print $0, tf_info[key]
    }
}' ATHA_NOMOTIF_OUTPUTS/regulons/ATHA_rankedRegulons.tsv ATHA_NOMOTIF_OUTPUTS/regulons/ATHA_edgeTable.tsv >> ATHA_NOMOTIF_OUTPUTS/regulons/ATHA_network.tsv