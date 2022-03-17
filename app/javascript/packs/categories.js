const api_url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId='

// document.getElementById("30-300").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-300');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("30-301").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-301');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("30-302").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-302');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("30-303").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-303');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("30-304").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-304');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("30-307").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-307');
//     ScrollWindow("recipe_list");
// }


// document.getElementById("30-309").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-309');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("30-310").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-310');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("30-311").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-311');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("31-319").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=31-319');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("31-320").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=31-320');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("31-323").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=31-323');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("31-326").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=31-326');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("31-327").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=31-327');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("31-329").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=31-329');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("31-333").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=31-333');
//     ScrollWindow("recipe_list");
// }

// document.getElementById("31-335").onclick = function() {
//     GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=31-335');
//     ScrollWindow("recipe_list");
// }


/* for ( var i = 300; i < 312; i++ ) {
    if ( i == 305 || i == 306 || i == 308 ) {
        continue;
    }
    document.getElementById("30-" + i).onclick = function() {
        GetRakutenApi('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1018227086092671411&categoryId=30-' + i);
        ScrollWindow("recipe_list");
    }
} */

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
