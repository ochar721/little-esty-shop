class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
    @national_holidays = HolidayService.get_holidays
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulkdiscount = @merchant.bulk_discounts.create(bulkdiscount_params)

    if bulkdiscount.save
      redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
    else
      flash[:error] = "Please fill in all fields. #{error_message(bulkdiscount.errors)}."
      render :new
      redirect_to "/merchant/#{@merchant.id}/bulk_discounts/new"
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.destroy(params[:id])
    redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
  end

  private
  def bulkdiscount_params
     params.require(:bulk_discount).permit(:percent, :quantity_threshold, :name, :merchant_id)
  end
end
