# keiba_data
## 目的
- 競馬のデータを取得して予想に役立てたい
- JRA-VANのデータをいい感じに加工して、扱えるようにする

## やること
- EveryDB2で取得したデータを、rubyで扱いやすい形にする
    - そのあと、データをどうするかはまたその時に考える


## ざっくりとした構造
- Template_keiba_table
    - 馬単位のデータ
    - Template_keiba_table_umaban
        - Table_x_uma_race
    - レース単位のデータ
    - Table_x_race
    - Table_x_harai