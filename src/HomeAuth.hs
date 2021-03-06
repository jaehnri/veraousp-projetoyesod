{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module HomeAuth where

import Foundation
import Yesod.Core
import Yesod
import Yesod.Auth

getHomeAuthR :: Handler Html
getHomeAuthR = do
    maid <- maybeAuthId
    defaultLayout
        [whamlet|
            <p>Observação: Logue como "admin" para ser um administrador.
            <p>Apenas admins podem adicionar restaurantes à lista.
            <p>Qualquer um logado pode visualizar a lista. 
            <p>Seu atual auth ID: #{show maid}
            $maybe _ <- maid
                <p>
                    <a href=@{AuthR LogoutR}>Logout
                <p>
                <a href=@{AdminR}>Ir para a página de Admin
            $if maid == Nothing
                <a href=@{AuthR LoginR}> Login
            <br>
            <a href=@{HomeR}>Voltar
        |]

postHomeAuthR :: Handler Html
postHomeAuthR = do
    setMessage "Voce fez alguma alteracao na página"
    redirect HomeR