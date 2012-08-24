module ViewMacros
  def view_should_render_template params
    describe 'rendered template' do
      before do
        render
      end
      it { view.should render_template(:index) }
    end
  end
end
