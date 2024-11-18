namespace coink_api.Middleware{
    public class ExceptionMiddleware{
        private readonly RequestDelegate _next;
        private readonly ILogger<ExceptionMiddleware> _logger;
        public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger){
            _next = next;
            _logger = logger;
        }

        public async Task Invoke(HttpContext context){
            try{
                await _next(context);
            }
            catch(Exception ex){
                _logger.LogError(ex, "An error occurred.");
                context.Response.ContentType = "application/json";
                context.Response.StatusCode = StatusCodes.Status500InternalServerError;
                var errorResponse = new {Message = "An unexpected error occurred."};
                await context.Response.WriteAsJsonAsync(errorResponse);
            }
        }
    }
}