// 生成したURL
const url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411';

// 書き出し
const updateText = (data) => {
    for (let i = 0; i < data.length; i++) {
        const insertHtml = `
        <div class="cp_card02">
            <div class="photo photo1">
                <a href="${data[i].recipeUrl}" target="_blank">
                    <img src="${data[i].foodImageUrl}" alt="${data[i].recipeTitle} 画像">
                </a>
            </div>
                <div class="description">
                    <h5>${data[i].recipeTitle}</h5>
                    <p>${data[i].recipeMaterial}</p>
                    <a class="btn link-btn" rel="nofollow" data-method="post" href="/recipes/scrape?url=${data[i].recipeUrl}">材料費をみる</a>
                </div>
            </div>
        </div>
        `;
        $('#recipe_list').append(insertHtml);
    }
}

// API取得
$.getJSON(url, (data) => {
    const recipes = data.result;
    updateText(recipes);
});