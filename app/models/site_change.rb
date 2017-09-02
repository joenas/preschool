class SiteChange < ActiveRecord::Base
  extend Enumerize

  belongs_to :preschool

  validates_presence_of :preschool
  validates_presence_of :data

  enumerize :state, in: [:new, :predicted, :active, :done], default: :new

  scope :recent, -> {where(state: :new)}
  scope :active, -> {where(state: :active)}
  scope :not_done, ->{where(state: [:new, :predicted, :active])}
  scope :grouped_by_state, -> {group(:state)}

  def not_done?
    state.to_sym != :done
  end

  def new_or_predicted?
    state.to_sym.in?([:new, :predicted])
  end

  def note_html
    note.gsub("\n", "<br>").html_safe
  end

  def extra_sanitized
    Rails::Html::FullSanitizer.new.sanitize(data['extra'].to_s).gsub(/\s{2,}/,"\n").gsub("\u00A0", "").strip
  end

  def note_prediction
    @note_prediction ||= extra_sanitized.lines.map(&:strip)
                          .select {|s| !s.empty? && ServiceRegistry.classifier.classify(s) == 'Goodsitechange'}
                          .join("\n").presence
  end

end
