module ApplicationHelper
  def default_meta_tags
    {
      site: 'CookCost',
      title: '楽天レシピから材料費シュミレーションサイト',
      reverse: true,
      charset: 'utf-8',
      description: '材料費シュミレーション',
      keywords: '料理, 節約, 材料費, 楽天レシピ',
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
        site: '@Runteq_sayaka'
      }
    }
  end
end
