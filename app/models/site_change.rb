class SiteChange < ActiveRecord::Base
  extend Enumerize

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :data

  enumerize :state, in: [:new, :active, :done], default: :new

  scope :recent, -> {where(state: :new)}

  def new_or_active?
    state.to_sym.in?([:new, :active])
  end

  def note_html
    note.gsub("\n", "<br>").html_safe
  end

  def extra_sanitized
    Rails::Html::FullSanitizer.new.sanitize(data['extra']).gsub(/\s{2,}/,"\n").strip
  end

  def note_prediction
    @note_prediction ||= extra_sanitized.lines.map(&:strip).select {|s| ServiceRegistry.classifier.classify(s) == 'Goodsitechange'}.join("\n").presence
  end

end
