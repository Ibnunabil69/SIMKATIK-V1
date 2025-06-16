import { z } from "zod";
import { ACCEPTED_IMAGE_TYPES, MAX_FILE_SIZE } from "~/constants/validatorRules";

export const updateProductSchema = z.object({
    nama_produk: z.string().optional(),
    kategori_id: z.coerce.number().int().positive().optional(),
    harga_jual: z.coerce.number().min(0).optional(),
    diskon: z.coerce.number().min(0).optional(),
    gambar_produk: z
        .instanceof(File, { message: "Format gambar tidak valid" })
        .refine((file) => file.size <= MAX_FILE_SIZE, "Ukuran gambar maksimal 2MB.")
        .refine(
            (file) => ACCEPTED_IMAGE_TYPES.includes(file.type),
            "Format gambar yang diterima: .jpg, .jpeg, .png",
        )
        .optional()
        .nullable(),
});

export type UpdateProductSchema = z.infer<typeof updateProductSchema>;
