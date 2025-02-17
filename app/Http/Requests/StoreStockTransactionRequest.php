<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use App\Models\Product;

class StoreStockTransactionRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return in_array($this->user()->role, ['admin', 'manager', 'warehouse']);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'product_id' => ['required', 'exists:products,id'],
            'transaction_type' => ['required', 'in:in,out'],
            'quantity' => ['required', 'numeric', 'min:0.01'],
            'unit_price' => ['required', 'numeric', 'min:0'],
            'reference_number' => ['required', 'string', 'max:50'],
            'notes' => ['nullable', 'string']
        ];
    }

    public function withValidator($validator)
    {
        $validator->after(function ($validator) {
            if ($this->transaction_type === 'out') {
                $product = Product::find($this->product_id);
                if ($product && $product->current_stock < $this->quantity) {
                    $validator->errors()->add(
                        'quantity',
                        'Insufficient stock. Available: ' . $product->current_stock
                    );
                }
            }
        });
    }

    public function messages(): array
    {
        return [
            'product_id.exists' => 'Selected product does not exist.',
            'quantity.min' => 'Quantity must be greater than zero.',
            'unit_price.min' => 'Unit price cannot be negative.',
        ];
    }
}
