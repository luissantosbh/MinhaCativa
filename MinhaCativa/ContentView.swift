//
//  ContentView.swift
//  MinhaCativa
//
//  Created by Luís Santos on 21/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var phone = ""
    @State private var price = 0
    @State private var tickets = [Ticket]()
    @State private var sector: Ticket.Sector = .inferior
    @State private var showingReport = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nome", text: $name)
                TextField("Telefone", text: $phone)
                Picker("Setor", selection: $sector) {
                    ForEach(Ticket.Sector.allCases, id: \.self) { sector in
                        Text(sector.rawValue)
                    }
                }
                Stepper(value: $price, in: 0...1000) {
                    Text("Preço: \(price)")
                }
                Button("Adicionar Ingresso") {
                    addTicket()
                }
                .padding(.top, 10)
                
                Button("Gerar relatório") {
                    showingReport.toggle()
                }
                .sheet(isPresented: $showingReport) {
                    ReportView(tickets: tickets)
                }
                .padding(.top, 10)
            }
            .navigationTitle("Cadastrar ingresso")
        }
    }
    func addTicket() {
        let ticket = Ticket(name: name, phone: phone, sector: sector, price: price)
        tickets.append(ticket)
        name = ""
        phone = ""
        price = 0
        sector = .inferior
    }
    
}

struct Ticket: Identifiable {
    var id = UUID()
    var name: String
    var phone: String
    var sector: Ticket.Sector
    var price: Int
    
    enum Sector: String, CaseIterable {
        case superior
        case inferior
        case camarote
    }
}

struct ReportView: View {
    var tickets: [Ticket]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Relatório de ingressos:")
                List(tickets) { ticket in
                    Text("Nome: \(ticket.name)")
                    Text("Telefone: \(ticket.phone)")
                    Text("Setor: \(ticket.sector.rawValue)")
                    Text("Preço: \(ticket.price)")
                }
            }
          //  .navigationTitle("Relatório")
        }
    }
}
