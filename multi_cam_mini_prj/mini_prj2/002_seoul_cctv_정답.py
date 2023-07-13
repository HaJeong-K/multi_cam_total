# -*- coding: utf-8 -*-
"""002_Seoul_CCTV_정답.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1f4plq-SRCrc43sMEaa2Yda5So8tX60Rq

# 서울시 CCTV 현황 분석


## https://opengov.seoul.go.kr

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

"""# I. 'seoulCCTV.csv' 파일 전처리"""

import warnings
warnings.filterwarnings('ignore')

"""> ## 1) 'seoulCCTV.csv' 파일 읽어오기"""

import pandas as pd

url = 'https://raw.githubusercontent.com/rusita-ai/pyData/master/seoulCCTV.csv'
CCTV = pd.read_csv(url)

CCTV.head()

"""> ## 2) '기관명'을 '구별'로 변경

* 열(Column) 이름 확인
"""

CCTV.columns

"""* 첫번째 열 이름 변경('기관명' -> '구별')"""

CCTV.rename(columns = {CCTV.columns[0] : '구별'}, inplace = True)

CCTV.head()

"""> ## 3) CCTV 데이터 현황 파악

* '소계' 오름차순 정렬
"""

CCTV.sort_values(by = '소계', ascending = True).head(7)

"""* '소계' 내림차순 정렬"""

CCTV.sort_values(by = '소계', ascending = False).head(7)

"""> ## 4) '최근증가율' 열(Column) 추가

* 최근 3년 CCTV '최근증가율' 열 추가
"""

CCTV['최근증가율'] = ((CCTV['2016년'] + CCTV['2015년'] + CCTV['2014년']) / CCTV['2013년도 이전']) * 100

CCTV

"""* '최근증가율' 열로 내림차순 정렬"""

CCTV.sort_values(by = '최근증가율', ascending = False).head(7)

"""# II.  'seoulPopulation.xlsx' 파일 전처리

> ## 1) 'seoulPopulation.xlsx' 파일 읽어오기
"""

import pandas as pd

url = 'https://raw.githubusercontent.com/rusita-ai/pyData/master/seoulPopulation.xlsx'
SDFP = pd.read_excel(url,
                     header = 2,
                     usecols = 'B, D, G, J, N')

SDFP.head()

"""> ## 2) 열(Column) 이름 변경"""

SDFP.rename(columns={SDFP.columns[0]:'구별',
                     SDFP.columns[1]:'인구수',
                     SDFP.columns[2]:'한국인',
                     SDFP.columns[3]:'외국인',
                     SDFP.columns[4]:'고령자'}, inplace=True)

SDFP.head()

"""> ## 3) NaN 확인

* .info( )
"""

SDFP.info()

"""* .value_counts( )
 - '합계' 삭제 필요
"""

SDFP['구별'].value_counts()

"""* .unique( )"""

len(SDFP['구별'].unique())

"""> ## 4) 인구 데이터 현황 파악

* '합계' 행(Row) 삭제
"""

SDFP.drop([0], inplace = True)

SDFP.head()

"""* '합계' 행(Row) 삭제 확인"""

len(SDFP['구별'].unique())

"""> ## 5) 파생변수 추가

* '외국인비율'과 '고령자비율' 열(Column)을 계산 후 추가
"""

SDFP['외국인비율'] = SDFP['외국인'] / SDFP['인구수'] * 100
SDFP['고령자비율'] = SDFP['고령자'] / SDFP['인구수'] * 100

SDFP.head()

"""* '인구수' 내림차순 정렬"""

SDFP.sort_values(by = '인구수', ascending = False).head(7)

"""* '외국인' 내림차순 정렬"""

SDFP.sort_values(by = '외국인', ascending = False).head(7)

"""* '외국인비율' 내림차순 정렬"""

SDFP.sort_values(by = '외국인비율', ascending = False).head(7)

"""* '고령자' 내림차순 정렬"""

SDFP.sort_values(by = '고령자', ascending = False).head(7)

"""* '고령자비율' 내림차순 정열"""

SDFP.sort_values(by = '고령자비율', ascending = False).head(7)

"""# III. CCTV 데이터와 인구 데이터 합치기

> ## 1) 두 데이터프레임에 공통으로 있는 '구별'로 merge
"""

DF = pd.merge(CCTV, SDFP, on = '구별')

DF.head()

DF.info()

"""> ## 2) 불필요한 열(Column) 삭제"""

del DF['2013년도 이전']
del DF['2014년']
del DF['2015년']
del DF['2016년']

DF.head()

"""> ## 3) '구별'을 index로 지정"""

DF.set_index('구별', inplace = True)

DF.head()

"""> ## 4) 상관계수(Correlation Coefficient)

* 범위 : -1 ~ 1(0이면 관계없음)
* '고령자비율' vs. '소계'
"""

import numpy as np

print(np.corrcoef(DF['고령자비율'], DF['소계']))

"""* '외국인비율' vs. '소계'"""

print(np.corrcoef(DF['외국인비율'], DF['소계']))

"""* '인구수'     vs. '소계'"""

print(np.corrcoef(DF['인구수'], DF['소계']))

"""> ## 5) CCTV 개수('소계')와 '인구수'의 관계

* '소계'(CCTV 개수) 내림차순 정렬
"""

DF.sort_values(by = '소계', ascending = False).head()

"""* '인구수' 내림차순 정렬"""

DF.sort_values(by='인구수', ascending=False).head()

"""# IV. Visualization

> ## 1) 막대(bar) 그래프 - pandas

* '소계'
"""

import matplotlib.pyplot as plt

DF['소계'].plot(kind = 'barh', grid = True, figsize = (10, 10))
plt.show()

"""* 정렬 - sort_value( )

"""

DF['소계'].sort_values().plot(kind = 'barh', grid = True, figsize = (10, 10))
plt.show()

"""* '인구수' 대비 CCTV비율 계산 후 정렬하여 시각화"""

DF['CCTV비율'] = DF['소계'] / DF['인구수'] * 100

DF['CCTV비율'].sort_values().plot(kind = 'barh', grid = True, figsize = (10, 10))
plt.show()

"""> ## 2) 산점도(scatter) - matplotlib

* '소계' ~ '인구수'
"""

plt.figure(figsize=(10, 7))
plt.scatter(DF['인구수'], DF['소계'], s = 50)

plt.xlabel('인구수')
plt.ylabel('CCTV')
plt.grid()
plt.show()

"""> ## 3) 회귀선 추가 - seaborn"""

import seaborn as sns

plt.figure(figsize = (12, 9))

sns.regplot(x = '인구수', y = '소계', data = DF,
            line_kws = {'color':'red'})

for n in range(len(DF)):
    plt.text(DF['인구수'][n] * 1.02,
             DF['소계'][n] * 0.98,
             DF.index[n],
             fontsize = 12)
plt.xlabel('인구수')
plt.ylabel('CCTV')
plt.grid()
plt.show()

"""#
#
#
# End Of Document
#
#
#
"""