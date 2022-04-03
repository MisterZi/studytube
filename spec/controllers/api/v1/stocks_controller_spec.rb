require 'rails_helper'

# Base Stocks controller specs
describe Api::V1::StocksController, type: :controller do
  describe 'POST #create Create stock' do
    context 'Success' do
      let(:result) do
        -> { post :create, params: { stock: { name: "Stock ##{rand(100_000)}", bearer_name: "Bearer ##{rand(100_000)}" } } }
      end

      it 'create bearer' do
        expect { result.call }.to change { Bearer.count }.by(1)
      end

      it 'create stock' do
        expect { result.call }.to change { Stock.count }.by(1)
      end
    end

    context 'Invalid stock params' do
      let(:result) do
        -> { post :create, params: { stock: { name: '', bearer_name: "Bearer ##{rand(100_000)}" } } }
      end

      it 'not create bearer' do
        expect { result.call }.not_to change { Bearer.count }
      end

      it 'not create stock' do
        expect { result.call }.not_to change { Stock.count }
      end
    end
  end

  describe 'PATCH #update Update stock' do
    let!(:bearer) { create(:bearer) }
    let(:stock) { create(:stock, bearer: bearer) }
    let(:new_stock_name) { stock.name + '_updated' }
    let(:new_bearer_name) { bearer.name + '_updated' }

    context 'Not change bearer' do
      let(:result) do
        -> { patch :update, params: { id: stock.id, stock: { name: new_stock_name } } }
      end

      it 'change stock' do
        expect { result.call }.to change { stock.reload.name }.from(stock.name).to(new_stock_name)
      end
    end
    
    context 'Change bearer' do
      let(:result) do
        -> { patch :update, params: { id: stock.id, stock: { name: new_stock_name, bearer_name: new_bearer_name } } }
      end

      it 'create new bearer' do
        expect { result.call }.to change { Bearer.count }.by(1)
      end

      it 'change stock bearer reference' do
        expect { result.call }.to change { stock.reload.bearer }
      end
    end

    context 'Invalid stock params' do
      let(:result) do
        -> { patch :update, params: { id: stock.id, stock: { name: '', bearer_name: new_bearer_name } } }
      end

      it 'not change stock' do
        expect { result.call }.not_to change { stock.reload.name }
      end

      it 'not create bearer' do
        expect { result.call }.not_to change { Bearer.count }
      end
    end
  end
end
