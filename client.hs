import Network.Socket hiding (recv)
import System.IO
import System.Environment
import qualified Network.Socket.ByteString as B
import qualified Data.ByteString.Char8 as C

formatGet :: String -> String
formatGet str = "GET /echo.php/?message="++str++" HTTP/1.1\n\r Hostname:10.62.0.54:8000"

main :: IO ()
main = withSocketsDo $ do 
    [host,port,message] <- getArgs
    addrinfos <- getAddrInfo Nothing (Just "10.62.0.207") (Just "8000")
    let serverAddr =  head addrinfos
    sock <- socket (addrFamily serverAddr) Stream defaultProtocol 
    connect sock (addrAddress serverAddr)
    B.sendAll sock $ C.pack $ formatGet  message
    msg <- B.recv sock 1024
    sClose sock
    putStrLn "Recieved"
    C.putStrLn msg

