import { PartialType } from '@nestjs/mapped-types';
import { CreateCharacterDto } from './create-character.dto';
import { IsNumber } from 'class-validator';

export class UpdateCharacterDto extends PartialType(CreateCharacterDto) {
  @IsNumber()
  accessory: number;

  @IsNumber()
  hair: number;

  @IsNumber()
  pants: number;

  @IsNumber()
  shirts: number;

  @IsNumber()
  shoes: number;
}
