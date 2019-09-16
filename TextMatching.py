# -*- coding: utf-8 -*-
import numpy as np

with open("/Users/cs402a/Desktop/PythonFile/New_ProductsInfo", "rt") as f:
    products = f.readlines()

score_category = list()
score_fabric = list()
score_pattern = list()

out_elements = ["SET", "set", "세트"]
top_elements = ["맨투맨", "상의", "후드티", "후드T", "후드t", "맨투T", "맨투t", "헨리넥", "BL", "bl", "슬리브", "블라우스", "셔츠",
                "남방", "NB", "nb", "팔T", "루즈T", "롱T", "박스T", "크롭T", "니트", "나시", "T", "가디건T", "mtm", "MTM", "반집업",
                "니트티", "조끼", "니트T", "블랑"]
outer_elements = ["가디건", "CD", "cd", "자켓", "JK", "jk", "코트", "야상", "점퍼", "아우터", "바람막이", "JP", "jp", "트렌치",
                  "집업", "셔츠jk", "셔츠JK", "무스탕", "ct", "CT", "니트cd", "니트CD", "니트가디건", "반팔가디건", "반팔CD", "반팔cd",
                  "긴팔가디건", "긴팔CD", "긴팔cd", "후드집업", "니트집업"]
dress_elements = ["원피스", "OPS", "ops" "드레스", "dress", "롱OPS", "니트원피스", "니트롱원피스", "니트미디원피스", "니트미니원피스",
                  "셔츠원피스", "니트 원피스", "셔츠미니원피스",'셔츠롱원피스']
skirt_elements = ["스커트", "치마", "SK", "skirt", "sk", "롱sk", "롱SK", "롱스커트", "니트스커트", "니트sk", "니트SK", "니트롱스커트",
                  "니트 롱스커트", "롱-스커트", "미니-스커트", "데님-스커트", "치마바지", "스커트팬츠"]
pants_elements = ["팬츠", "슬랙스", "숏츠", "SL", "sl", "바지", "쇼츠","PT", "pt", "니트팬츠", "jean", "JEAN", "블랙진", "일자P",
                  "일자진", "일자팬츠", "조거팬츠", "부츠P", "스키니", "데님P", "일자핏P"]

cotton_elements = ["폴리", "코튼", "cotton", "린넨", "T", "BL", "bl", "BLOUSE", "blouse", "블라우스", "반팔T", "긴팔T", "박스T",
                   "슬리브", "슬랙스", "맨투맨","mtm", "MTM", "맨투T", '후드T', "후드티", "헨리넥", "셔츠", "남방", "nb", "NB",
                   "루즈T", "롱T", "크롭T", "트렌치", "야상", "자켓", "jk", "JK", "면소재","블랑", "쉬폰", "플리츠", "블랙진", "텐셀",
                   "부츠컷P", "스키니P", "숏", "찰랑", "sk", "SK", "스커트", "면 소재", "팬츠", "sl", "SL", "원피스", "린넨원피스",
                   "셔츠원피스", "ops", "OPS", "바지", "후드", "드레스", "dress", "스키니", "블랙스키니", "블랙 스키니", "스키니팬"]
wool_elements = ["CD", "니트", "캐시미어", "캐시", "knit", "wool", "울니트", "가디건", "cd", "조끼", "헤링본", "트위드", "울", "앙고라",
                 "울코트", "양털", "코트", "짜임", "니트스커트", "니트sk", "니트SK", "니트원피스", "니트롱", "니트드레스", "니트원피스"]
leather_elements = ["가죽", "레더", "라이더", "rider", "라이더자켓", "레더무스탕", "레더스커트", "레더자켓", "leather"]
denim_elements = ["중청", "연청", "청자켓", "청색", "진청", "청바지", "청남방", "흑청", "데님", "생지", "청치마", "denim", "데님P",
                  "워싱", '데님숏', "데님sk", "데님SK", "데님스커트", "데님", "데님 스커트", "데님멜빵", "데님팬츠", "데님스키니", "데님숏츠",
                  "데님바지", "jean", "JEAN", "데님스키니", "데님 스키니", "밴딩 팬츠", "밴딩팬", "스키니청바지", "워싱스키니", "생지스키"]

checked_elements = ["체크", "check", "checked", "격자"]
floral_elements = ["플로랄", "플라워", "꽃", "flower"]
graphic_elements = ["프린팅", "레터링", "로고", "캐릭"]
plain_elements = ["무지"]
stripe_elements = ["스트라이프", "stripe", "줄무늬"]

for i in range(len(products)):
    score_category.append([])
    for j in range(5):
        score_category[i].append(0)

    score_fabric.append([])
    for j in range(4):
        score_fabric[i].append(0)

    score_pattern.append([])
    for j in range(5):
        score_pattern[i].append(0)

for i in range(len(products)):
    title = products[i].split("\'")[5]
    desc = products[i].split("\'")[9]

    for j in range(len(top_elements)):
        if top_elements[j] in title:
            score_category[i][0] += 1
        if top_elements[j] in desc:
            score_category[i][0] += 1
    for j in range(len(outer_elements)):
        if outer_elements[j] in title:
            score_category[i][1] += 1
        if outer_elements[j] in desc:
            score_category[i][1] += 1
    for j in range(len(dress_elements)):
        if dress_elements[j] in title:
            score_category[i][2] += 1
        if dress_elements[j] in desc:
            score_category[i][2] += 1
    for j in range(len(skirt_elements)):
        if skirt_elements[j] in title:
            score_category[i][3] += 1
        if skirt_elements[j] in desc:
            score_category[i][3] += 1
    for j in range(len(pants_elements)):
        if pants_elements[j] in title:
            score_category[i][4] += 1
        if pants_elements[j] in desc:
            score_category[i][4] += 1
    for j in range(len(out_elements)):
        if out_elements[j] in title:
            for k in range(5):
                score_category[i][k] = -100

    for j in range(len(cotton_elements)):
        if cotton_elements[j] in title:
            score_fabric[i][0] += 1
        if cotton_elements[j] in desc:
            score_fabric[i][0] += 1
    for j in range(len(wool_elements)):
        if wool_elements[j] in title:
            score_fabric[i][1] += 1
        if wool_elements[j] in desc:
            score_fabric[i][1] += 1
    for j in range(len(leather_elements)):
        if leather_elements[j] in title:
            score_fabric[i][2] += 1
        if leather_elements[j] in desc:
            score_fabric[i][2] += 1
    for j in range(len(denim_elements)):
        if denim_elements[j] in title:
            score_fabric[i][3] += 1
        if denim_elements[j] in desc:
            score_fabric[i][3] += 1
    for j in range(len(out_elements)):
        if out_elements[j] in title:
            for k in range(4):
                score_fabric[i][k] = -100

    for j in range(len(checked_elements)):
        if checked_elements[j] in title:
            score_pattern[i][0] += 1
        if checked_elements[j] in desc:
            score_pattern[i][0] += 1
    for j in range(len(floral_elements)):
        if floral_elements[j] in title:
            score_pattern[i][1] += 1
        if floral_elements[j] in desc:
            score_pattern[i][1] += 1
    for j in range(len(graphic_elements)):
        if graphic_elements[j] in title:
            score_pattern[i][2] += 1
        if graphic_elements[j] in desc:
            score_pattern[i][2] += 1
    for j in range(len(plain_elements)):
        if plain_elements[j] in title:
            score_pattern[i][3] += 1
        if plain_elements[j] in desc:
            score_pattern[i][3] += 1
    for j in range(len(stripe_elements)):
        if stripe_elements[j] in title:
            score_pattern[i][4] += 1
        if stripe_elements[j] in desc:
            score_pattern[i][4] += 1
    for j in range(len(out_elements)):
        if out_elements[j] in title:
            for k in range(5):
                score_pattern[i][k] = -100
    if (score_pattern[i][0] == 0) and (score_pattern[i][2] == 0) and (score_pattern[i][3] == 0) and (score_pattern[i][1] == 0) and (score_pattern[i][4] == 0):
        score_pattern[i][3] += 1

    sum = 0
    max1 = 0
    for j in range(1, 5):
        if score_category[i][max1] < score_category[i][j]:
            max1 = j
    if max1 == 0:
        category = "top"
    elif max1 == 1:
        category = "outer"
    elif max1 == 2:
        category = "dress"
    elif max1 == 3:
        category = "skirt"
    else:
        category = "pants"
    sum += score_category[i][max1]

    max2 = 0
    for j in range(1, 4):
        if score_fabric[i][max2] < score_fabric[i][j]:
            max2 = j
    if max2 == 0:
        fabric = "cotton"
    elif max2 == 1:
        fabric = "wool"
    elif max2 == 2:
        fabric = "leather"
    else:
        fabric = "denim"
    sum += score_fabric[i][max2]

    max3 = 0
    for j in range(1, 5):
        if score_pattern[i][max3] < score_pattern[i][j]:
            max3 = j
    if max3 == 0:
        pattern = "checked"
    elif max3 == 1:
        pattern = "floral"
    elif max3 == 2:
        pattern = "graphic"
    elif max3 == 3:
        pattern = "plain"
    else:
        pattern = "stripe"
    sum += score_pattern[i][max3]

    avg = float(sum)/3
    var = pow(score_category[i][max1] - avg, 2) + pow(score_fabric[i][max2] - avg, 2) + pow(score_pattern[i][max3] - avg, 2)

    fDirectory = "/Users/cs402a/Desktop/PythonFile/New_MatchedProducts"
    w_desc = category, fabric, pattern, str(sum), str(int(var))
    print(str(w_desc))

    with open(fDirectory, "a") as f:
        f.write(str(w_desc))
        f.write("\n")
