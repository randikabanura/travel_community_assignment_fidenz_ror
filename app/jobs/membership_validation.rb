class MembershipValidation
  include SuckerPunch::Job

  def perform(user_id)
    ActiveRecord::Base.connection_pool.with_connection do
      payment = Payment.find_by(user_id: user_id)
      plan = payment.plan
      if Date.today > payment.exp_date
        payment.delete
        payment.save
        user = User.find(user_id)
        user.revoke "pro_user_"+plan
        user.save
      end
    end
  end
end
