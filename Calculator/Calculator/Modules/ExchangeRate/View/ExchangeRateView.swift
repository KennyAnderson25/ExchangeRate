//
//  ContentView.swift
//  Calculator
//
//  Created by Kenny on 1/06/24.
//

import SwiftUI


struct ExchangeRateView: View {
    
    @StateObject var presenter: ExchangeRatePresenter
    weak var delegate: UITextFieldDelegate?
    
    @State private var name = ""
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("Change")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 200)
                
                VStack(alignment: .leading) {
                    Text("Cambia tus dólares y soles al instante")
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
            
            HStack {
                Text("VENTA: S/. \(presenter.sellRate)")
                    .font(.headline)
                    .foregroundColor(.red)
                    .accessibility(identifier: "Sell")
                
                Spacer()
                
                Text("COMPRA S/. \(presenter.buyRate)")
                    .font(.headline)
                    .foregroundColor(.black)
                    .accessibility(identifier: "Buy")
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("TIENES")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
                HStack {
                    TextField("Ingresa la cantidad", text: $presenter.originAmount)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .keyboardType(.decimalPad)
                        .frame(width: 235)
                        .accessibility(identifier: "originAmountTextField")
                    
                    Text(presenter.lblSource)
                        .font(.headline)
                        .foregroundColor(.black)
                        .accessibility(identifier: "lblSource")
                }
                
                HStack {
                    Text("RECIBES")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
                HStack {
                    TextField("Cantidad convertida", text: $presenter.destinationAmount)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .keyboardType(.decimalPad)
                        .frame(width: 235)
                        .disabled(true)
                        .accessibility(identifier: "destinationAmountTextField")
                    
                    Text(presenter.lblDestionation)
                        .font(.headline)
                        .foregroundColor(.black)
                        .accessibility(identifier: "lblDestionation")
                }
            }
            .padding()
            
            Button(action: {
                presenter.swapCurrencies()
            }) {
                Image(systemName: "arrow.up.arrow.down")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color(.systemOrange))
                    .cornerRadius(12)
            }
            .accessibility(identifier: "swapButton")
        }
        .padding()
        .onAppear {
            presenter.loadExchangeRates()
        }
        .alert(isPresented: $presenter.showAlert) {
                    Alert(title: Text("Error"), message: Text("Hubo un problema al obtener los datos"), dismissButton: .default(Text("Entendido")))
                }
    
}}

struct ExchangeRateView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateRouter.createModule()
    }
}
