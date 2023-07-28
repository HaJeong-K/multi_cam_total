# -*- coding: UTF-8 -*-
import streamlit as st
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
import plotly.graph_objects as go
from plotly.subplots import make_subplots

def main():
    st.title("Hello World!")

    st.text("Hello World2")

    title = st.text_input('Movie title', 'Life of Brian')
    st.write('The current movie title is', title)

    # 교재 챕터5
    # 마크다운
    st.markdown('이 텍스트는 :red[빨간 글자], 굵게 하기 **:blue[파란 글자]**')
    st.write('-' * 50)
    st.markdown("""
    # 파트 2
    - 피타고라스 정리 :blue[$\sqrt{x^2+y^2}=1$]
    """)
    st.write('-' * 50)
    st.markdown("## part 3. test \n"
                " - Streamlit **정말 좋네요!** \n"
                "   * 이 텍스트는 :red[빨간 글자], 굵게 하기 **:blue[파란 글자]**")
    
    st.title("HTML CSS 마크다운 적용")
    html_css = """
    <style>
      th, td {
        border-bottom: 1px solid #ddd;
      }
    </style>

    <table>
      <thead>
        <tr>
          <th>이름</th>
          <th>나이</th>
          <th>직업</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Evan</td>
          <td>25</td>
          <td>데이터 분석가</td>
        </tr>
        <tr>
          <td>Sarah</td>
          <td>25</td>
          <td>프로덕트 오너</td>
        </tr>
      </tbody>
    </table>
    """
    st.markdown(html_css, unsafe_allow_html=True)

    ## 데이터 프레임
    st.title("데이터 프레임")
    df = sns.load_dataset('iris')
    st.dataframe(df.head(50))
    st.write(df.head(50))

    ## metric
    tips = sns.load_dataset('tips')
    tip_max = tips['tip'].max()
    tip_min = tips['tip'].min()
    st.metric(label = "Max Tip", value = tip_max, delta = tip_max - tip_min)
    st.table(tips.describe())


    ## 시각화 matplotlib
    m_tips = tips.loc[tips['sex'] == 'Male', :]
    f_tips = tips.loc[tips['sex'] == 'Female', :]

   
    # 성별 구분하기
    st.dataframe(m_tips)
    st.dataframe(f_tips)

    # fig, ax = plt.subplot() >> 객체지향문법, 꼭 정의하고 하기
    
    fig, ax = plt.subplots(ncols=2, figsize=(10, 6), sharex=True, sharey=True)
    ax[0].scatter(x = m_tips['total_bill'], y = m_tips['tip'])
    ax[0].set_title('Male')
    ax[1].scatter(x = f_tips['total_bill'], y = f_tips['tip'])
    ax[1].set_title('Female')
    fig.supxlabel('Total Bill($)')
    fig.supylabel('Tip($)')
    st.pyplot(fig)

    ##seaborn
    m_tips = tips.loc[tips['sex'] == 'Male', :]
    f_tips = tips.loc[tips['sex'] == 'Female', :]
    fig1, ax = plt.subplots(ncols=2, figsize=(10, 6), sharex=True, sharey=True)
    sns.scatterplot(data = m_tips, x = 'total_bill', y = 'tip', hue = 'smoker', ax = ax[0])
    ax[0].set_title('Male')
    ax[0].set_xlabel('Total_Bill')

    fig1.supxlabel('Total Bill($)')
    fig1.supylabel('Tip($)')

    st.pyplot(fig1)


    # plotly
    fig = make_subplots(rows = 1,
                        cols = 2,
                        subplot_titles=('Male', 'Female'),
                        shared_yaxes=True,
                        shared_xaxes=True,
                        x_title='Total Bill($)'
                        )
    fig.add_trace(go.Scatter(x = m_tips['total_bill'], y = m_tips['tip'], mode='markers'), row=1, col=1)
    fig.add_trace(go.Scatter(x = f_tips['total_bill'], y = f_tips['tip'], mode='markers'), row=1, col=2)
    fig.update_yaxes(title_text="Tip($)", row=1, col=1)
    fig.update_xaxes(range=[0, 60])
    fig.update_layout(showlegend=False)

    # Display visualization
    st.plotly_chart(fig, use_container_width=True)





if __name__ == "__main__":
    main()