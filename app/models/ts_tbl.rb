class TsTbl < ActiveRecord::Base
  belongs_to :user
  has_many :ts_result
  has_attached_file :ts,
                    :path => ':rails_root/public/ts/:id',
                    :url => '/ts/:id'
                    
  do_not_validate_attachment_file_type :ts
end