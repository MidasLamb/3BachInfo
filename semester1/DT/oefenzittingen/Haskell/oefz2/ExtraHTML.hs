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
  toHtml = error "Not implemented"

instance HTML a => HTML [a] where
  toHtml = error "Not implemented"

-- The encoding of the following unordered list as an HtmlElement
--   <ul>
--   <li>Appels</li>
--   <li>Bananas</li>
--   <li>Oranges</li>
--   </ul>
exampleUL :: HtmlElement
exampleUL = error "Not implemented"

data AddressBook = DEFINE_ADDRESSBOOK

myAddressBook :: AddressBook
myAddressBook = error "Not implemented"

instance HTML AddressBook where
  toHtml = error "Not implemented"

renderElement :: HtmlElement -> String
renderElement = error "Not implemented"

render :: HTML a => a -> String
render = renderElement . toHtml

