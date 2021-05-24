/**
 Request methods for HTTP.

 The request method token is the primary source of request semantics;
 it indicates the purpose for which the client has made this request
 and what is expected by the client as a successful result.

 - SeeAlso:
 - [RFC 7231](https://tools.ietf.org/html/rfc7231) defines all method except PATCH.
 - [RFC 5789](https://tools.ietf.org/html/rfc5789) defines the PATCH method.
 */
public enum Method: String {

    /// Establish a tunnel to the server identified by the target resource.
    case CONNECT

    /// Remove all current representations of the target resource.
    case DELETE

    /// Transfer a current representation of the target resource.
    case GET

    /// Same as GET, but only transfer the status line and header section.
    case HEAD

    /// Describe the communication options for the target resource.
    case OPTIONS

    /// Requests that a set of changes described in the request entity be applied to the resource identified by the Request URI.
    case PATCH

    /// Perform resource-specific processing on the request payload.
    case POST

    /// Replace all current representations of the target resource with the request payload.
    case PUT

    /// Perform a message loop-back test along the path to the target resource
    case TRACE
}
