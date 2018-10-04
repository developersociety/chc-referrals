# TODO: test
module ApplicationHelper
  def classes_none_available(partner, usage)
    available = partner.max_monthly_referrals - (usage[partner.slug] || 0)
    ' white bg-red' if available.zero?
  end

  def requires_review(status)
    status == 'review' ? 'with-bg-black': 'with-bg'
  end

  def status_text(status)
    classes = 'sm f1 truncate'
    classes << ' red' if status == 'declined'
    tag.span(status.capitalize, class: classes)
  end
end
