#Веб-приложение Flashcards

Имеет систему перевода от Bing Translator и Флеш-карточки для заучивания переведенных слов

Для включения Bing Translator необходимо зарегестрировать аккаунт на 
[Microsoft Asure Marketplace](https://datamarket.azure.com/) , 
добавить в него новое приложение и в rails-консоли запустить команду 
`File.open(File.join(Rails.root, '.bing_secret'), 'w') {|file| file.write 'CLIENT_ID CLIENT_SECRET'}`
, где CLIENT_ID - id приложения, CLIENT_SECRET - секретный код приложения.
