import apiClient from "~/lib/apiClient";
import type { Product } from "../types";
import type { UpdateProductSchema } from "../validator";

const ProductService = {
    getAllProducts: async (): Promise<Product[]> => {
        const { data } = await apiClient.get("/produk");
        return data;
    },
    updateProduct: async (id: number, { ...input }: UpdateProductSchema): Promise<Product> => {
        const formData = new FormData();
        formData.append('_method', 'PUT');
        if (input.gambar_produk) {
            formData.append("gambar_produk", input.gambar_produk);
        }

        // biome-ignore lint/complexity/noForEach: <explanation>
        Object.entries(input).forEach(([key, value]) => {
            if (key !== "gambar_produk" && value !== undefined) {
                formData.append(key, value as string | Blob);
            }
        });

        console.log(input);
        console.log(formData);
        const { data } = await apiClient.post(`/admin/produk/${id}`, formData, {
            headers: { "Content-Type": "multipart/form-data" },
        });
        console.log(data);
        return data;
    },
    deleteProduct: async (id: number): Promise<void> => {
        await apiClient.delete<void>(`/admin/produk/${id}`);
    },
};

export default ProductService;
