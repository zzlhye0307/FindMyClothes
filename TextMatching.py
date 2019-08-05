# -*- coding: utf-8 -*-
import numpy as np

with open("/Users/cs402a/Desktop/PythonFile/상품정보", "rt") as f:
    products = f.readlines()

title = list()
desc = list()
for i in range(len(products)):
    title.append(products[i].split("\'")[5])
    desc.append(products[i].split("\'")[9])

score_category = []
for i in range(len(products)):
    score_category.append([])
    for j in range(5):
        score_category[i].append(0)

out_elements = ["SET", "set", "세트"]
top_elements = ["맨투맨", "상의", "후드티", "후드T", "후드t", "맨투T", "맨투t", "헨리넥", "BL", "bl", "슬리브", "블라우스", "셔츠",
                "남방", "NB", "nb", "팔T", "루즈T", "롱T", "박스T", "크롭T", "니트", "나시", "T", "가디건T", "mtm", "MTM", "반집업",
                "니트티", "조끼"]
outer_elements = ["가디건", "CD", "cd", "자켓", "JK", "jk", "코트", "야상", "점퍼", "아우터", "바람막이", "JP", "jp", "트렌치",
                  "집업", "셔츠jk", "셔츠JK", "무스탕", "ct", "CT", "니트cd", "니트CD", "니트가디건", "반팔가디건", "반팔CD", "반팔cd",
                  "긴팔가디건", "긴팔CD", "긴팔cd", "후드집업", "니트집업"]
dress_elements = ["원피스", "OPS", "ops" "드레스", "dress", "롱OPS", "니트원피스", "니트롱원피스", "니트미디원피스", "니트미니원피스",
                  "셔츠원피스", "니트 원피스"]
skirt_elements = ["스커트", "치마", "SK", "skirt", "sk", "롱sk", "롱SK", "롱스커트", "니트스커트", "니트sk", "니트SK", "니트롱스커트",
                  "니트 롱스커트", "롱-스커트", "미니-스커트", "데님-스커트"]
pants_elements = ["팬츠", "슬랙스", "숏츠", "SL", "sl", "바지", "쇼츠","PT", "pt", "니트팬츠"]

for i in range(len(products)):
    for j in range(len(top_elements)):
        if top_elements[j] in title[i]:
            score_category[i][0] += 1
        if top_elements[j] in desc[i]:
            score_category[i][0] += 1
    for j in range(len(outer_elements)):
        if outer_elements[j] in title[i]:
            score_category[i][1] += 1
        if outer_elements[j] in desc[i]:
            score_category[i][1] += 1
    for j in range(len(dress_elements)):
        if dress_elements[j] in title[i]:
            score_category[i][2] += 1
        if dress_elements[j] in desc[i]:
            score_category[i][2] += 1
    for j in range(len(skirt_elements)):
        if skirt_elements[j] in title[i]:
            score_category[i][3] += 1
        if skirt_elements[j] in desc[i]:
            score_category[i][3] += 1
    for j in range(len(pants_elements)):
        if pants_elements[j] in title[i]:
            score_category[i][4] += 1
        if pants_elements[j] in desc[i]:
            score_category[i][4] += 1
    for j in range(len(out_elements)):
        if out_elements[j] in title[i]:
            for k in range(5):
                score_category[i][k] = -100
    print(str(i) + "번째 상품인 '" + title[i] + "'의 category score :" + str(score_category[i]))


score_fabric = []
for i in range(len(products)):
    score_fabric.append([])
    for j in range(4):
        score_fabric[i].append(0)

cotton_elements = ["폴리", "코튼", "cotton", "린넨"]
wool_elements = ["니트", "캐시미어", "캐시", "knit", "wool", "울니트"]
leather_elements = ["가죽", "레더", "라이더", "rider"]
denim_elements = ["중청", "연청", "청자켓", "청색", "진청", "청바지", "청남방", "흑청", "데님", "생지", "청치마"]

for i in range(len(products)):
    for j in range(len(cotton_elements)):
        if cotton_elements[j] in title[i]:
            score_fabric[i][0] += 1
        if cotton_elements[j] in desc[i]:
            score_fabric[i][0] += 1
    for j in range(len(wool_elements)):
        if wool_elements[j] in title[i]:
            score_fabric[i][1] += 1
        if wool_elements[j] in desc[i]:
            score_fabric[i][1] += 1
    for j in range(len(leather_elements)):
        if leather_elements[j] in title[i]:
            score_fabric[i][2] += 1
        if leather_elements[j] in desc[i]:
            score_fabric[i][2] += 1
    for j in range(len(denim_elements)):
        if denim_elements[j] in title[i]:
            score_fabric[i][3] += 1
        if denim_elements[j] in desc[i]:
            score_fabric[i][3] += 1
    for j in range(len(out_elements)):
        if out_elements[j] in title[i]:
            for k in range(4):
                score_fabric[i][k] = -100
    print(str(i) + "번째 상품인 '" + title[i] + "'의 fabric score :" + str(score_fabric[i]))
