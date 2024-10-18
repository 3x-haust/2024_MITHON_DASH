import { PartialType } from '@nestjs/mapped-types';
import { CreateUserDto } from './create-user.dto';
import { IsNumber, IsString } from 'class-validator';

export class UpdateUserDto extends PartialType(CreateUserDto) {
  @IsNumber()
  distance: number;

  @IsString()
  items: string;

  @IsNumber()
  money: number;

  @IsString()
  userName: string;
}
