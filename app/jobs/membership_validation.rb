class MembershipValidation
  include SuckerPunch::Job

  def perform(user_id)
    ActiveRecord::Base.connection_pool.with_connection do
      payment = Payment.find_by(user_id: user_id)
      if Date.today > payment.exp_date
        user = User.find(user_id)
        user.revoke 'pro_user_' + payment.plan.to_s
        user.save
        payment.destroy
      end
    end
  end
end
