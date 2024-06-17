TRAIN="/home/sl237/all_six_datasets/ETT-small/ETTh1.csv 
    /home/sl237/all_six_datasets/ETT-small/ETTh2.csv
    /home/sl237/all_six_datasets/ETT-small/ETTm1.csv
    /home/sl237/all_six_datasets/ETT-small/ETTm2.csv
    /home/sl237/all_six_datasets/electricity/electricity.csv
    /home/sl237/all_six_datasets/exchange_rate/exchange_rate.csv
    /home/sl237/all_six_datasets/traffic/traffic.csv
    /home/sl237/all_six_datasets/weather/weather.csv"

INIT_TEST="/home/sl237/all_six_datasets/electricity/electricity.csv 
/home/sl237/all_six_datasets/weather/weather.csv"

TEST="/home/sl237/all_six_datasets/ETT-small/ETTh1.csv 
    /home/sl237/all_six_datasets/ETT-small/ETTh2.csv
    /home/sl237/all_six_datasets/ETT-small/ETTm1.csv
    /home/sl237/all_six_datasets/ETT-small/ETTm2.csv
    /home/sl237/all_six_datasets/electricity/electricity.csv
    /home/sl237/all_six_datasets/exchange_rate/exchange_rate.csv
    /home/sl237/all_six_datasets/traffic/traffic.csv
    /home/sl237/all_six_datasets/weather/weather.csv"

PROMPT="/home/gw22/python_project/ltsm_proj/ltsm/prompt/prompt_data_normalize_csv_split"
epoch=1
downsample_rate=20
freeze=0
OUTPUT_PATH="output/ltsmt_new_csv_large_lr${lr}_loraFalse_down${downsample_rate}_freeze${freeze}_e${epoch}_pred${pred_len}/"
lr=1e-3


for pred_len in 96
do

    CUDA_VISIBLE_DEVICES=3 python3 ../main_hf.py \
    --model_id test_run \
    --model LTSM \
    --model_name_or_path meta-llama/Llama-2-7b-hf \
    --train_epochs ${epoch} \
    --batch_size 100 \
    --pred_len ${pred_len} \
    --gradient_accumulation_steps 64 \
    --data_path ${TRAIN} \
    --test_data_path ${INIT_TEST} \
    --test_data_path_list ${TEST} \
    --prompt_data_path ${PROMPT} \
    --freeze ${freeze} \
    --learning_rate ${lr} \
    --downsample_rate ${downsample_rate} \
    --output_dir ${OUTPUT_PATH}
done
