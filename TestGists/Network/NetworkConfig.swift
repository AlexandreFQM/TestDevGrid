//
//  NetworkConfig.swift
//  TestGists
//
//  Created by Alexandre Furquim on 07/04/21.
//

import Foundation

// MARK: - Environment
/**
 Enum dos environments e suas respectivas urls
 - Author:
 Alexandre Furquim
 */
public enum Environment: String {
    ///Ambiente de desenvolvimento
    case develop = "develop"
    ///Ambiente de teste
    case qa = "qa"
    ///Ambiente de produção
    case prod = "prod"
}

//MARK: - NetworkConfig
/**
 Classe responsável pela configuração do ambiente e EntryPoint
 - Author:
 Alexandre Furquim
 */
public class NetworkConfig {
    ///Variavel de ambiente
    var environment: Environment?
    ///Variavel do remoteConfig do Firebase
    //var remoteConfig = RemoteConfig.remoteConfig()
    ///Constante responsável pela instancia unica da classe NetworkConfig
    public static let shared = NetworkConfig()
    ///Constante responsável pela instancia unica do bundle
    private let bundle = Bundle(for: NetworkConfig.self)
    // Variavel responsável pelo token
    private var userIDToken: String = ""
    
    ///Init da classe
    public init() {}
    // MARK: setEnvironment
    /**
     Função responsável por configurar o ambiente
     - Author:
     Alexandre Furquim
     - parameters:
     - environment: Variável do ambiente a ser configurado
     */
    public func setEnvironment(_ environment: Environment) {
        NetworkConfig.shared.environment = environment
    }
            
    // MARK: getEntryPoint
    /**
     Função responsável por configurar o EntryPoint
     - Author:
     Alexandre Furquim
     - returns:
     A URL base do ambiente selecionado
     */
    public func getEntryPoint() -> URL? {
        if let env = NetworkConfig.shared.environment {
            return URL(string: env.rawValue)
        }
        return nil
    }
}
