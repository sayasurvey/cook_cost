module ApplicationHelper
  def default_meta_tags
    {
      site: 'CookCost',
      title: '楽天レシピから材料費計算サイト',
      reverse: true,
      charset: 'utf-8',
      description: '材料費計算',
      keywords: '材料費, 計算, 自炊, 節約, 節約レシピ',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('icon.png') },
        { href: image_url('icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@cookcost'
      }
    }
  end
end
