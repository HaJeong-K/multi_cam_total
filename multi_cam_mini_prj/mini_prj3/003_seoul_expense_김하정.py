# -*- coding: utf-8 -*-
"""003_Seoul_Expense_김하정.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1-nNwy_lh-cxWmmJr5DFZBRU_cAuwzbFd

# 서울시 업무추진비 분석


## https://opengov.seoul.go.kr
## https://github.com/seoul-opengov/opengov

# O. 한글폰트 설치 후 진행

> ## 1) 한글 폰트 설치
"""

import matplotlib.font_manager as fm

# Linux
!apt-get -qq -y install fonts-nanum > /dev/null

# Colab
fontpath = '/usr/share/fonts/truetype/nanum/NanumBarunGothic.ttf'
font = fm.FontProperties(fname = fontpath, size = 10)
# fm._rebuild()
!rm -rf ~/.cache/matplotlib -rf

"""> ## 2) <font color = 'red'>설치 후 '**런타임 다시 시작**'</font>

* 런타임 강제 종료 후 다시 시작
"""

import os

os.kill(os.getpid(), 9)

"""> ## 3) 한글 폰트 설정"""

import matplotlib.pyplot as plt
import matplotlib as mpl
import matplotlib.font_manager as fm

mpl.rcParams['axes.unicode_minus'] = False

path = '/usr/share/fonts/truetype/nanum/NanumGothicBold.ttf'
font_name = fm.FontProperties(fname = path, size = 10).get_name()
plt.rc('font', family = font_name)
# fm._rebuild()
!rm -rf ~/.cache/matplotlib -rf

"""# I. 데이터 수집"""

import warnings
warnings.filterwarnings('ignore')

"""> ## 1) 파일 다운로드 함수 정의

* 01. github 경로 지정
* 02. 다운로드 폴더 지정
* 03. 다운로드 폴더 확인 또는 생성
* 04. 1월 ~ 12월 업무추진비 파일 다운로드
"""

import requests
import os
import pathlib

def get_seoul_expense_list(extension, year, data_folder):

    # 01
    expense_list_year_url = 'https://github.com/seoul-opengov/opengov/raw/master/expense_list' + str(year) + '/'

    # 02
    expense_list_year_dir = data_folder + str(year) + '/'

    # 03
    if(os.path.isdir(expense_list_year_dir)):
        print('폴더({0})가 존재합니다. {0}년 데이터의 다운로드를 시작합니다.'.format(year))
    else:
        print('폴더({0})를 생성했습니다. {0}년 데이터의 다운로드를 시작합니다.'.format(year))
        pathlib.Path(expense_list_year_dir).mkdir(parents = True, exist_ok = True)

    # 04
    for k in range(12):
        file_name = '{0}{1:02d}_expense_list.{2}'.format(year, k+1, extension)
        url = expense_list_year_url + file_name
        print(url)
        r = requests.get(url)
        with open(expense_list_year_dir + file_name, 'wb') as f:
            f.write(r.content)

"""> ## 2) 함수 실행 옵션

* 파일 타입 지정
* 연도 지정(2017~2019)
* 폴더 지정
"""

extension = 'csv'

years = [2017, 2018, 2019]

data_folder = 'data_folder_'

"""> ## 3) 파일 다운로드 함수 실행"""

for year in years:
  get_seoul_expense_list(extension, year, data_folder)

"""> ## 4) 다운로드 결과 확인"""

!ls -l data_folder_*

"""# II. 데이터 전처리

> ## 1) 파일 구조 및 정보 확인

* 파일 한 개 사용
"""

import pandas as pd

df = pd.read_csv('data_folder_2017/201701_expense_list.csv')

df.info()

"""> ## 2) 함수 정의

* 열(Column) 이름 확인
"""

df.columns

"""* 열(Column) 이름 변경 함수"""

def change_csv_file_first_line_value(old_file_name, new_file_name):
    # 읽기 모드 열기
    with open(old_file_name, encoding = 'utf-8') as f:
        # 한 줄씩 lines 리스트의 각 요소에 할당
        lines = f.read().splitlines()

    # 변경할 열(Column) 이름 지정
    lines[0] = 'nid,제목,url,부서레벨1,부서레벨2,부서레벨3,부서레벨4,\
부서레벨5,집행연도,집행월,예산,집행,구분,부서명,\
집행일시,집행장소,집행목적,대상인원,결제방법,집행금액'

    # 쓰기 모드 열기
    with open(new_file_name, 'w', encoding = 'utf-8') as f:
        # 리스트 각 요소 개행문자(\n)로 연결해서 파일 저장
        f.write('\n'.join(lines))

"""* '_new' 추가한 새파일 저장 함수"""

# 인자: 연도, 데이터 파일이 있는 폴더
def change_year_csv_file_first_line_value(year, data_folder):

    # 파일 폴더 지정
    expense_list_year_dir = data_folder + str(year) + '/'

    # 확장자 이름
    extension = 'csv'

    # 지정한 폴더에 있는 월별 업무추진비 파일에서 첫 번째 줄의 열 이름을 변경
    for k in range(12):
        # 기존 파일 이름
        old_file_name = expense_list_year_dir + '{0}{1:02d}_expense_list.{2}'.format(year, k+1, extension)

        # 새파일 이름
        new_file_name = expense_list_year_dir + '{0}{1:02d}_expense_list_new.{2}'.format(year, k+1, extension)

        # 열(Column) 이름 변경 함수
        change_csv_file_first_line_value(old_file_name, new_file_name)

"""> ## 3) 함수 적용"""

data_folder = 'data_folder_'

years = [2017, 2018, 2019]

for year in years:
    print('{}년 데이터의 첫 번째 줄의 열 이름을 변경해서 새 파일에 저장합니다.'.format(year))
    change_year_csv_file_first_line_value(year, data_folder)

print('모든 데이터의 첫 번째 줄의 열 이름을 변경해서 새 파일로 저장했습니다.')

"""* 새파일 생성 확인"""

!ls -l data_folder_*/*new.csv

"""* 열(Column) 이름 변경 확인"""

df_new = pd.read_csv('data_folder_2017/201701_expense_list_new.csv')

df.columns, df_new.columns

"""> ## 4) 결측치 확인

* .info( ) 적용
"""

df_new.info()

"""* isna( ) 적용
 - '부서레벨3', '부서레벨4', '부서레벨5', '예산', '집행', '구분'
"""

df_new.isna().sum(axis = 0)

"""> ## 5) 연도별 파일 통합

* 파일 통합 함수 정의
"""

def select_columns_save_file(year, data_folder, drop_columns_list):

    expense_list_year_dir = data_folder + str(year) + '/'
    expense_list_tidy_file = '{}_expense_list_tidy.csv'.format(year)
    df_year = pd.DataFrame()

    for k in range(12):
        # 새파일 이름 지정
        file_name = '{0}{1:02d}_expense_list_new.csv'.format(year, k+1)

        # DtaFrame 형식으로 csv 데이터 불러오기
        df_month = pd.read_csv(expense_list_year_dir + file_name)

        # df_month 새로 추가해서 df_year에 다시 할당
        df_year = df_year.append(df_month, ignore_index = True)

    df_year_drop = df_year.drop(columns = drop_columns_list)
    new_file_name = expense_list_year_dir + expense_list_tidy_file
    df_year_drop.to_csv(new_file_name, index = False)

    print('==> {} 파일 생성'.format(expense_list_tidy_file))

"""* 함수 실행 옵션"""

data_folder = 'data_folder_'

years = [2017, 2018, 2019]

drop_columns_list = ['nid', 'url', '부서레벨3', '부서레벨4', '부서레벨5', '예산', '집행', '구분']

"""* 파일 통합 함수 실행"""

for year in years:
    print('{}년 파일 통합중...'.format(year))
    select_columns_save_file(year, data_folder, drop_columns_list)
print('파일 통합 완료.')

"""* 생성된 통합 파일 확인"""

!ls -l data_folder_*/*tidy*

"""* 2017 통합 파일 정보"""

df_2017 = pd.read_csv('data_folder_2017/2017_expense_list_tidy.csv')

df_2017.info()

"""> ## 6) 전체 파일 통합

* DataFrame : df_expense_all
"""

import pandas as pd

data_folder = 'data_folder_'

years = [2017, 2018, 2019]

df_expense_all = pd.DataFrame()


for year in years:
    expense_list_year_dir = data_folder + str(year) + '/'
    expense_list_tidy_file = '{}_expense_list_tidy.csv'.format(year)

    path_file_name = expense_list_year_dir + expense_list_tidy_file

    df_expense = pd.read_csv(path_file_name)
    df_expense_all = df_expense_all.append(df_expense, ignore_index = True)

"""* 전체 통합 DataFrame 확인"""

df_expense_all.info()

"""* 'seoulExpense.csv' 파일 저장"""

df_expense_all.to_csv('seoulExpense.csv')

"""# III.  데이터 분석

> ## 1) 연도별 집행횟수

* 연도별 .value_count( )
"""

DF1 = df_expense_all.집행연도.value_counts()



"""* 막대그래프 시각화"""

plt.figure(figsize = (9, 7))

plt.bar(DF1.index,
        DF1['집행연도'],
        width = 0.7)

plt.legend()
plt.show()



"""> ## 2) 연도별 집행금액

* 연도별 .pibot_table( )
"""

DF = pd.pivot_table(df_expense_all,
                    index = '집행연도',
                    values = '집행금액',
                    aggfunc = 'sum')

DF



"""* 막대그래프 시각화"""

plt.figure(figsize = (9, 7))

plt.bar(DF.index,
        DF['집행금액'],
        width = 0.7, label = '집행금액')

plt.legend()
plt.show()



"""> ## 3) 월별 집행금액

* 월별 .pivot_table( )
"""

DF2 = pd.pivot_table(df_expense_all,
                    index = '집행월',
                    values = '집행금액',
                    aggfunc = 'sum')

DF2



"""* 연별/월별 .pivot_table( )"""

DF3 = pd.pivot_table(df_expense_all,
                    index = '집행월',
                    columns = '집행연도',
                    values = '집행금액',
                    aggfunc = 'sum')

DF3



"""* 막대그래프 시각화"""





"""> ## 4) 부서별 집행금액

* 부서별_level1 .pivot_table( )
"""

DFl = pd.pivot_table(df_expense_all,
                    index = '부서레벨1',
                    values = '집행금액',
                    aggfunc = 'sum')

DFl



"""* 부서별_level2 .pivot_table( )"""

DFl2 = pd.pivot_table(df_expense_all,
                    index = '부서레벨2',
                    values = '집행금액',
                    aggfunc = 'sum')

DFl2.head() + DFl2.tail()



"""* 집행금액별 내림차순 정렬"""



"""* 막대그래프 시각화"""



"""* 워드클라우드 시각화"""

from wordcloud import WordCloud

korean_font_path = '/usr/share/fonts/truetype/nanum/NanumBarunGothic.ttf'

wc = WordCloud(font_path = korean_font_path,
               background_color='white',
               width = 800, height = 600)

frequencies = dept_level2_total['집행금액']

wordcloud_image = wc.generate_from_frequencies(frequencies)

plt.figure(figsize=(14, 9))
plt.axis('off')
plt.imshow(wordcloud_image, interpolation = 'bilinear')
plt.show()

"""> ## 5) 요일별 집행횟수

* 시간정보 확인
"""

df_expense_all['집행일시'].values

"""* pd.to_datetime( ) 변환"""

expense_date_time = pd.to_datetime(df_expense_all['집행일시'])

expense_date_time.values

"""* '집행일시_요일' 행(Column) 추가
 - dt.weekday : 날짜를 요일로 변환
"""

week_day_name = ['월', '화', '수', '목', '금', '토', '일']

df_expense_all['집행일시_요일'] = [week_day_name[weekday] for weekday in expense_date_time.dt.weekday]

"""* 추가 정보 확인"""

df_expense_all.head()

"""* 요일별 집행횟수 확인"""

expense_weekday = df_expense_all['집행일시_요일'].value_counts()

expense_weekday

"""* 요일순 정렬 : .reindex( )"""

expense_weekday = expense_weekday.reindex(index = week_day_name)

expense_weekday

"""* 막대그래프 시각화"""

expense_weekday.plot.bar(rot = 0, figsize = (10, 7))
plt.title('요일별 업무추진비 집행 횟수')
plt.xlabel('요일')
plt.ylabel('집행 횟수')
plt.show()

"""> ## 6) 시간별 집행횟수

* '집행일시_시간' 행(Column) 추가
 - dt.hour : 날짜를 시간으로 변환
"""

df_expense_all['집행일시_시간'] = [hour for hour in expense_date_time.dt.hour]

"""* 추가 정보 확인"""

df_expense_all.head()

"""* 시간별 집행횟수 확인"""

expense_hour_num = df_expense_all['집행일시_시간'].value_counts()

expense_hour_num

"""* 시간순 정렬 : .reindex( )
 - 8시 기준
"""

work_hour = [ (k+8)%24 for k in range(24)]
expense_hour_num = expense_hour_num.reindex(index = work_hour)

expense_hour_num

"""* 막대그래프 시각화"""

expense_hour_num.plot.bar(rot = 0, figsize = (10, 7))
plt.title('시간별 업무추진비 집행 횟수')
plt.xlabel('집행 시간')
plt.ylabel('집행 횟수')
plt.show()

"""> ## 7) 시간별 집행금액

* 시간별 .pivot_table( )
"""



"""* 막대그래프 시각화"""



"""#
#
#
# End Of Document
#
#
#
"""