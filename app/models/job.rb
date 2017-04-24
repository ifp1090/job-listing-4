class Job < ApplicationRecord
  validates :title, presence: { message: "请填写标题" }
  validates :category_name, presence: { message: "请选择职位类型" }
  validates :description, presence: { message: "请填写职位描述" }
  validates :wage_upper_bound, presence: { message: "请填写最低薪水" }
  validates :wage_lower_bound, presence: { message: "请填写最高薪水" }
  validates :wage_lower_bound, numericality: { greater_than: 0, message: "最小薪水必须大于零" }
  validates :wage_lower_bound, numericality: { less_than: :wage_upper_bound, message: "薪水下限不能高于薪水上限" }
  validates :contact_email, presence: { message: "请填写联系邮箱" }
  validates :location, presence: { message: "请填写工作地点" }

# 最大薪资必须大于最小薪资

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :publish, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }

  has_many :resumes
  belongs_to :category
  belongs_to :user

  has_many :job_relationships
  has_many :members, through: :job_relationships, source: :user
end
