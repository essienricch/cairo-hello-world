#[starknet::interface]
trait ICounter <T> {
    // Increase counter by 1:
    fn increaseCounter(ref self: T, a: u128);

    // Decrease counter by 1:
    fn decreaseCounter(ref self: T, a: u128);

    // Get counter balance:
    fn getCounter(self: @T) -> u128;

}

#[starknet::contract]
mod Counter{
    use traits::Into;

    #[storage]
    struct Storage{
        value: u128,
    }

    #[constructor]
    fn constructor(ref self: ContractState, value_: u128){
        self.value.write(value_);
    }

    #[abi(embed_v0)]
    impl Counter of super::ICounter<ContractState>{
        
        fn increaseCounter(ref self: ContractState, a: u128){
            self.value.write(self.value.read() + a);
        }

        fn decreaseCounter(ref self: ContractState, a: u128){
            self.value.write(self.value.read() - a);
        }

        fn getCounter(self: @ContractState) -> u128{
            self.value.read()
        }
    }
}