-- Simple (X)HTML markup.
data Attr = Attr String String
  deriving (Eq,Show)

data HtmlElement
  = HtmlString String                    -- Plain text.
  | HtmlTag String [Attr] HtmlElements   -- Structured markup.
  deriving (Eq, Show)

type HtmlElements = [HtmlElement]

example :: HtmlElement
example =
  HtmlTag "a" [Attr "href" "https://www.kuleuven.be/kuleuven/"]
    [HtmlString "KU Leuven"]

-- HTML renderable class.
class HTML a where
  toHtml :: a -> HtmlElement

data Link =
  Link
    String  -- Link target.
    String  -- Text to show.
  deriving (Eq,Show)

instance HTML Link where
  toHtml (Link link text) = HtmlTag "a" [Attr "href" link] [HtmlString text]

instance HTML a => HTML [a] where
  toHtml xs = HtmlTag "ul" [] [toHtml x | x <- xs]

-- The encoding of the following unordered list as an HtmlElement
--   <ul>
--   <li>Appels</li>
--   <li>Bananas</li>
--   <li>Oranges</li>
--   </ul>
exampleUL :: HtmlElement
exampleUL = HtmlTag "ul" [] [HtmlTag "li" [] [HtmlString "Appels"],HtmlTag "li" [] [HtmlString "Bananas"],HtmlTag "li" [] [HtmlString "Oranges"]]

data AddressBook = Book [Adress]
data Adress = Adress String String [Email]
data Email = Work String | Private String

myAddressBook :: AddressBook
myAddressBook = Book [Adress "Yana" "Berbers" [Work "yana.berbers@kul.be"], Adress "Jonah" "Moens" [Work "jonah.moens@kul.be"]]

instance HTML AddressBook where
  toHtml (Book list) = toHtml list
instance HTML Adress where
    toHtml (Adress first last emails) = HtmlTag "section" [] [HtmlTag "h1" [] [HtmlString (first ++ " " ++ last)], toHtml emails]
instance HTML Email where
    toHtml x
        | Work email <- x       = HtmlString email
        | Private email <- x    = HtmlString email

renderElement :: HtmlElement -> String
renderElement = error "Not implemented"

render :: HTML a => a -> String
render = renderElement . toHtml

