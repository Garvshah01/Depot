class OrderMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'

  def received(order)
    @items = order.line_items
    @items.each do |item|
      item.product.product_image.each_with_index do |img, idx|
        image_name = "#{img.record_id}#{img.id}"
        idx == 0 ? attachments.inline[image_name] = img.download : attachments[image_name] = img.download
      end
    end
    @language = LANGUAGES.to_h[order.user.language]
    I18n.with_locale(@language) { mail to: order.email, subject: t('.subject') }
  end

  def all_orders(orders)
    @orders = orders
    @language = LANGUAGES.to_h[orders.first.user.language]
    headers['X-SYSTEM-PROCESS-ID'] = Process.pid
    I18n.with_locale(@language) { mail to: orders.first.user.email, subject: t('.subject') }
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
