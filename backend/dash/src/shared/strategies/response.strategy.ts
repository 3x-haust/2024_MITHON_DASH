import { HttpStatus, Injectable } from '@nestjs/common';

@Injectable()
export class ResponseStrategy {
  success(message: string, data?: any) {
    return this.createResponse(HttpStatus.OK, message, data);
  }

  error(message: string, error: any) {
    return this.createResponse(
      HttpStatus.INTERNAL_SERVER_ERROR,
      message,
      null,
      error,
    );
  }

  notFound(message: string) {
    return this.createResponse(HttpStatus.NOT_FOUND, message);
  }

  noContent(message: string) {
    return this.createResponse(HttpStatus.NO_CONTENT, message);
  }

  private createResponse(
    status: HttpStatus,
    message: string,
    data?: any,
    error?: any,
  ) {
    const response: any = {
      status,
      timeStamp: new Date().toISOString(),
      message,
    };

    if (data) response.data = data;
    if (error) response.error = error.message;

    return response;
  }
}
