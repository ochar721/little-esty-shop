class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
    @national_holidays = HolidayService.get_holidays
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])
    discount.update(bulkdiscount_params)
    redirect_to "/merchant/#{@merchant.id}/bulk_discounts/#{discount.id}"
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant_id = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant_id = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant_id.bulk_discounts.new(bulkdiscount_params)

    if @bulk_discount.save
      redirect_to "/merchant/#{@merchant_id.id}/bulk_discounts"
    else
      flash[:error] = "Please fill in all fields. #{error_message(  @bulk_discount.errors)}."
      redirect_to "/merchant/#{@merchant_id.id}/bulk_discounts/new"
    end
  end


  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.destroy(params[:id])
    redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
  end

  private
  def bulkdiscount_params
     params.fetch(:bulk_discount, {}).permit(:percent, :quantity_threshold, :name, :merchant_id)
  end
end
