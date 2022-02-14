module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  def declension_of_words(number, word1, word2, word3)
    if (number % 100).between?(11, 14)
      "#{number} #{word3}"
    elsif number % 10 == 1
      "#{number} #{word1}"
    elsif (number % 10).between?(2,4)
      "#{number} #{word2}"
    else
      "#{number} #{word3}"
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
