document.getElementById("30-300").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-300');
    ScrollWindow("recipe_list");
}

document.getElementById("30-301").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-301');
    ScrollWindow("recipe_list");
}

document.getElementById("30-302").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-302');
    ScrollWindow("recipe_list");
}

document.getElementById("30-307").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-307');
    ScrollWindow("recipe_list");
}

document.getElementById("30-304").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-304');
    ScrollWindow("recipe_list");
}

document.getElementById("30-310").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-310');
    ScrollWindow("recipe_list");
}

document.getElementById("30-305").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-305');
    ScrollWindow("recipe_list");
}

document.getElementById("30-308").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-308');
    ScrollWindow("recipe_list");
}

document.getElementById("30-312").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-312');
    ScrollWindow("recipe_list");
}

document.getElementById("30-311").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-311');
    ScrollWindow("recipe_list");
}

document.getElementById("30-309").onclick = function() {
    GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-309');
    ScrollWindow("recipe_list");
}

function GetRakutenApi(url) {
    document.getElementById('recipe_list').innerHTML = '';
    function updateText(data) {
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
}

function ScrollWindow(elem) {
    var element = document.getElementById(elem);
    var rect = element.getBoundingClientRect();
    var elemtop = rect.top + window.pageYOffset;
    document.documentElement.scrollTop = elemtop;
}
