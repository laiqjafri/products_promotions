require 'checkout'

RSpec.describe Checkout, type: :lib do
  before do
    @item1_promo = PromotionXPriceOnYItems.new(8.5, 2)
    @total_promo = PromotionXPercentOffOnY.new(10, 60)
    @item1 = Item.new '001', "Travel Card Holder", 9.25, [@item1_promo]
    @item2 = Item.new '002', "Personalised cufflinks", 45
    @item3 = Item.new '003', "Kids T-shirt", 19.95
    @c = Checkout.new [@total_promo]
  end

  it "should add up to 0.0 when empty" do
    expect(@c.total).to eq 0.0
  end

  it "should scan item correctly" do
    expect { @c.scan(@item1) }.to change(@c, :basket_count).from(0).to(1)
    expect { @c.scan(@item1); @c.scan(@item2) }.to change(@c, :basket_count).from(1).to(3)
  end

  it "should calculate checkout total correctly" do
    @c.scan(@item1); @c.scan(@item2); @c.scan(@item3);
    expect(@c.total).to eq 66.78

    @c.empty!

    @c.scan(@item1); @c.scan(@item3); @c.scan(@item1);
    expect(@c.total).to eq 36.95

    @c.empty!

    @c.scan(@item1); @c.scan(@item2); @c.scan(@item1); @c.scan(@item3)
    expect(@c.total).to eq 73.76
  end
end
