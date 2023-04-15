class TicketWindowMutations {
  static const String uploadCoupon = r'''
      mutation ImportTaxInvoice($params: ImportTaxInvoiceParams!, $taxInvoice: Upload) {
        importTaxInvoice(params: $params, taxInvoice: $taxInvoice) {
          id
          payments {
            id
            status
          }
        }
      }
      ''';
  static const String updateCoupon = r'''
      mutation UpdateTaxInvoice($id: UUID4!, $params: UpdateTaxInvoiceParams!, $taxInvoice: Upload) {
        updateTaxInvoice(id: $id, params: $params, taxInvoice: $taxInvoice) {
          id
          payments {
            id
            status
          }
        }
      }
      ''';
}
